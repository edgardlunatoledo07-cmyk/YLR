const { initializeTestEnvironment, assertFails, assertSucceeds } = require('@firebase/rules-unit-testing');
const { doc, getDoc, setDoc, serverTimestamp } = require('firebase/firestore');
const path = require('path');
const fs = require('fs');

const PROJECT_ID = 'ylr-beta';
const UID = 'abc12345xyz';
const CODE = 'usuarioABC12345';

let env;

function ctx(uid) {
  return env.authenticatedContext(uid).firestore();
}

function backup(extra = {}) {
  return {
    participantCode: CODE,
    version: '0.2.0-beta',
    localBackup: { route: 'personal', completed: [], scores: [], simulations: [] },
    lastBackupAt: new Date(),
    ...extra,
  };
}

before(async () => {
  env = await initializeTestEnvironment({
    projectId: PROJECT_ID,
    firestore: { rules: fs.readFileSync(path.resolve(__dirname, '..', 'firestore.rules'), 'utf8') },
  });
});

after(async () => { await env.cleanup(); });

beforeEach(async () => { await env.clearFirestore(); });

async function seed(uid = UID) {
  await env.withSecurityRulesDisabled(async (c) => {
    await setDoc(doc(c.firestore(), 'users', uid), {
      participantCode: CODE,
      version: '0.2.0-beta',
      createdAt: new Date(),
      localBackup: { route: 'personal', completed: [], scores: [], simulations: [] },
      lastBackupAt: new Date(),
    });
  });
}

it('el dueno lee su documento', async () => {
  await seed();
  await assertSucceeds(getDoc(doc(ctx(UID), 'users', UID)));
});

it('un extrano no lee el documento ajeno', async () => {
  await seed();
  await assertFails(getDoc(doc(ctx('otroUid999'), 'users', UID)));
});

it('crea con forma valida', async () => {
  await assertSucceeds(setDoc(doc(ctx(UID), 'users', UID), {
    ...backup(),
    createdAt: serverTimestamp(),
  }));
});

it('rechaza create sin participantCode', async () => {
  const { participantCode, ...rest } = backup();
  await assertFails(setDoc(doc(ctx(UID), 'users', UID), {
    ...rest,
    createdAt: serverTimestamp(),
  }));
});

it('acepta update de localBackup', async () => {
  await seed();
  await assertSucceeds(setDoc(doc(ctx(UID), 'users', UID), {
    participantCode: CODE,
    localBackup: { route: 'tens', completed: ['tens:LES-01'], scores: [], simulations: [] },
    lastBackupAt: new Date(),
  }, { merge: true }));
});

it('rechaza update con participantCode invalido', async () => {
  await seed();
  await assertFails(setDoc(doc(ctx(UID), 'users', UID), {
    participantCode: 'otro',
    localBackup: { route: 'personal', completed: [], scores: [], simulations: [] },
    lastBackupAt: new Date(),
  }, { merge: true }));
});

it('rechaza una lista fuera de tope', async () => {
  await seed();
  const huge = Array.from({ length: 1001 }, (_, i) => `personal:${i}`);
  await assertFails(setDoc(doc(ctx(UID), 'users', UID), {
    participantCode: CODE,
    localBackup: { route: 'personal', completed: [], scores: huge, simulations: [] },
    lastBackupAt: new Date(),
  }, { merge: true }));
});

it('rechaza cambiar participantCode por otro codigo valido', async () => {
  await seed();
  await assertFails(setDoc(doc(ctx(UID), 'users', UID), {
    participantCode: 'usuarioZZZZ9999',
    localBackup: { route: 'personal', completed: [], scores: [], simulations: [] },
    lastBackupAt: new Date(),
  }, { merge: true }));
});

it('permite fijar participantCode en un documento heredado', async () => {
  await env.withSecurityRulesDisabled(async (c) => {
    await setDoc(doc(c.firestore(), 'users', UID), {
      version: '0.1.0',
      localBackup: { route: 'personal', completed: [], scores: [], simulations: [] },
      lastBackupAt: new Date(),
    });
  });
  await assertSucceeds(setDoc(doc(ctx(UID), 'users', UID), {
    participantCode: CODE,
    localBackup: { route: 'personal', completed: ['personal:LES-01'], scores: [], simulations: [] },
    lastBackupAt: new Date(),
  }, { merge: true }));
});

it('rechaza un elemento que no es string', async () => {
  await seed();
  await assertFails(setDoc(doc(ctx(UID), 'users', UID), {
    participantCode: CODE,
    localBackup: { route: 'personal', completed: [{ x: 1 }], scores: [], simulations: [] },
    lastBackupAt: new Date(),
  }, { merge: true }));
});

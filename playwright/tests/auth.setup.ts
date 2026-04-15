import { test as setup } from '@playwright/test';

const authFile = '.auth/user.json';

setup('login y guardar sesión', async ({ page }) => {
  const baseURL = process.env.BASE_URL || '';
  const user = process.env.USER || '';
  const password = process.env.PASSWORD || '';

  await page.goto(baseURL);

  // Ajustar selectores según proyecto real
  await page.getByLabel('Usuario').fill(user);
  await page.getByLabel('Password').fill(password);
  await page.getByRole('button', { name: /login/i }).click();

  // Esperar login exitoso
  await page.waitForLoadState('networkidle');

  // Guardar sesión
  await page.context().storageState({ path: authFile });
});
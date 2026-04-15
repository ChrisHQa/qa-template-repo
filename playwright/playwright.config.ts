import { defineConfig } from '@playwright/test';
import * as dotenv from 'dotenv';

dotenv.config();

export default defineConfig({
  testDir: './tests',

  retries: 1,

  use: {
    baseURL: process.env.BASE_URL || '',
    storageState: '.auth/user.json',
    headless: true,
    trace: 'on-first-retry',  
    screenshot: 'only-on-failure',
  },

  projects: [
    {
      name: 'setup',
      testMatch: /.*\.setup\.ts/,
    },
    {
      name: 'tests',
      dependencies: ['setup'],
    },
  ],

  reporter: [
    ['list'],
    ['html', { open: 'never' }]
  ],
});
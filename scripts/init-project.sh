#!/bin/bash

echo "🚀 Inicializador de proyecto QA"
echo "--------------------------------"

# =========================
# VALIDACIÓN GIT
# =========================
echo ""
echo "🔍 Verificando Git..."

if ! command -v git >/dev/null 2>&1; then
  echo "❌ Git no está instalado."
  exit 1
fi

echo "✅ Git detectado"

# =========================
# PARAMETROS
# =========================
PROJECT_NAME=$1
OPTION=$2
FRONT_REPO=$3
BACK_REPO=$4
REPO_UNICO=$3

if [ -z "$PROJECT_NAME" ]; then
  echo "❌ El nombre del proyecto es obligatorio"
  exit 1
fi

# =========================
# CREAR BASE
# =========================
mkdir -p repo-under-test

# =========================
# OPCIONES DE PROYECTO
# =========================

if [ "$OPTION" == "1" ]; then
  # Monorepo
  if [ -z "$REPO_UNICO" ]; then
    echo "❌ Debés ingresar una URL"
    exit 1
  fi

  if [ ! -d "repo-under-test/app" ]; then
    echo "📦 Clonando repo..."
    git clone "$REPO_UNICO" repo-under-test/app
  else
    echo "⚠️ repo-under-test/app ya existe"
  fi

elif [ "$OPTION" == "2" ]; then
  # Front + Back
  if [ -z "$FRONT_REPO" ] || [ -z "$BACK_REPO" ]; then
    echo "❌ Debés ingresar ambas URLs"
    exit 1
  fi

  if [ ! -d "repo-under-test/front" ]; then
    echo "📦 Clonando FRONT..."
    git clone "$FRONT_REPO" repo-under-test/front
  fi

  if [ ! -d "repo-under-test/back" ]; then
    echo "📦 Clonando BACK..."
    git clone "$BACK_REPO" repo-under-test/back
  fi

elif [ "$OPTION" == "3" ]; then
  echo "📁 Solo estructura, no se clonan repos"

else
  echo "❌ Opción inválida"
  exit 1
fi

# =========================
# QA STRUCTURE
# =========================
mkdir -p qa/test-cases/$PROJECT_NAME

# =========================
# README PERSONALIZADO
# =========================
if [ -f README.md ]; then
  sed -i "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" README.md 2>/dev/null || true
fi

# =========================
# VALIDACIÓN OPENCODE
# =========================
echo ""
echo "🤖 Verificando OpenCode..."

if ! command -v opencode >/dev/null 2>&1; then
  echo "⚠️ OpenCode no está instalado."
  echo "👉 Instalalo según tu entorno antes de usar el agente QA"
else
  echo "✅ OpenCode detectado"
fi

# =========================
# VALIDACIÓN NODE.JS
# =========================
echo ""
echo "🔍 Verificando Node.js..."

if ! command -v node >/dev/null 2>&1; then
  echo "❌ Node.js no está instalado."
  echo "👉 Instalalo desde: https://nodejs.org/"
  exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
  echo "❌ npm no está disponible."
  echo "👉 Reinstalá Node.js correctamente."
  exit 1
fi

echo "✅ Node.js detectado: $(node -v)"
echo "✅ npm detectado: $(npm -v)"

# =========================
# PLAYWRIGHT SETUP
# =========================
echo ""
echo "🎭 Configurando Playwright..."

mkdir -p playwright
cd playwright || exit

if [ ! -f "package.json" ]; then
  echo "📦 Inicializando package.json..."
  npm init -y
fi

echo "📦 Instalando Playwright..."
if ! npm list @playwright/test >/dev/null 2>&1; then
  npm install -D @playwright/test
else
  echo "✅ Playwright ya instalado"
fi

echo "🌐 Instalando navegadores..."
if [ ! -d "$HOME/.cache/ms-playwright" ]; then
  npx playwright install
else
  echo "✅ Navegadores ya instalados"
fi

mkdir -p tests
mkdir -p fixtures

if [ ! -f "tests/example.spec.ts" ]; then
  echo "🧪 Creando test de ejemplo..."
  cat <<EOL > tests/example.spec.ts
import { test, expect } from '@playwright/test';

test('example', async ({ page }) => {
  await page.goto('https://example.com');
  await expect(page).toHaveTitle(/Example/);
});
EOL
fi

cd ..

echo "✅ Playwright listo"

echo ""
echo "✅ Proyecto listo"
echo "📁 Estructura generada:"
echo "- repo-under-test/"
echo "- qa/test-cases/$PROJECT_NAME"
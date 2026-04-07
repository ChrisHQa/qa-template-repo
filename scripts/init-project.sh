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
# NOMBRE DEL PROYECTO
# =========================
read -p "📌 Nombre del proyecto: " PROJECT_NAME

if [ -z "$PROJECT_NAME" ]; then
  echo "❌ El nombre del proyecto es obligatorio"
  exit 1
fi

# =========================
# TIPO DE PROYECTO
# =========================
echo ""
echo "Seleccioná tipo de proyecto:"
echo "1) Monorepo (un solo repo)"
echo "2) Front + Back (dos repos)"
echo "3) Solo estructura (sin repos)"

read -p "👉 Opción (1/2/3): " OPTION

# =========================
# CREAR BASE
# =========================
mkdir -p repo-under-test

# =========================
# OPCIÓN 1: MONOREPO
# =========================
if [ "$OPTION" == "1" ]; then
  read -p "🔗 URL del repo: " REPO_UNICO

  if [ -z "$REPO_UNICO" ]; then
    echo "❌ Debés ingresar una URL"
    exit 1
  fi

  if [ -d "repo-under-test/app" ]; then
    echo "⚠️ La carpeta repo-under-test/app ya existe, se omite clone"
  else
    echo "📦 Clonando repo..."
    git clone "$REPO_UNICO" repo-under-test/app
  fi

# =========================
# OPCIÓN 2: FRONT + BACK
# =========================
elif [ "$OPTION" == "2" ]; then
  read -p "🔗 URL repo FRONT: " FRONT_REPO
  read -p "🔗 URL repo BACK: " BACK_REPO

  if [ -z "$FRONT_REPO" ] || [ -z "$BACK_REPO" ]; then
    echo "❌ Debés ingresar ambas URLs"
    exit 1
  fi

  if [ ! -d "repo-under-test/front" ]; then
    echo "📦 Clonando FRONT..."
    git clone "$FRONT_REPO" repo-under-test/front
  else
    echo "⚠️ FRONT ya existe, se omite"
  fi

  if [ ! -d "repo-under-test/back" ]; then
    echo "📦 Clonando BACK..."
    git clone "$BACK_REPO" repo-under-test/back
  else
    echo "⚠️ BACK ya existe, se omite"
  fi

# =========================
# OPCIÓN 3: SOLO ESTRUCTURA
# =========================
elif [ "$OPTION" == "3" ]; then
  echo "📁 Se crea solo la estructura base"

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

# Inicializar npm si no existe
if [ ! -f "package.json" ]; then
  echo "📦 Inicializando package.json..."
  npm init -y
fi

# Instalar Playwright
echo "📦 Instalando Playwright..."
if ! npm list @playwright/test >/dev/null 2>&1; then
  npm install -D @playwright/test
else
  echo "✅ Playwright ya instalado"
fi

# Instalar navegadores
echo "🌐 Instalando navegadores..."
if [ ! -d "$HOME/.cache/ms-playwright" ]; then
  npx playwright install
else
  echo "✅ Navegadores ya instalados"
fi

# Crear estructura básica
mkdir -p tests
mkdir -p fixtures

# Crear test de ejemplo si no existe
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


# =========================
# FIN
# =========================
echo ""
echo "✅ Proyecto listo"
echo "📁 Estructura generada:"
echo "- repo-under-test/"
echo "- qa/test-cases/$PROJECT_NAME"


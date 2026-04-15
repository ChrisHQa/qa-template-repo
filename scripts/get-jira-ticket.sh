#!/bin/bash

# Cargar variables de entorno
source .env

# Validar jq
if ! command -v jq >/dev/null 2>&1; then
  echo "❌ jq no está instalado."
  echo "👉 Instalalo desde: https://jqlang.org/download/"
  exit 1
fi

ISSUE_KEY=$1

if [ -z "$ISSUE_KEY" ]; then
  echo "❌ Tenés que pasar un ISSUE KEY (ej: TEC-123)"
  exit 1
fi

echo "🔎 Obteniendo ticket $ISSUE_KEY..."

RESPONSE=$(curl -s -u "$JIRA_EMAIL:$JIRA_TOKEN" \
  -H "Accept: application/json" \
  "$JIRA_BASE/rest/api/3/issue/$ISSUE_KEY")

# Validación básica
if [[ "$RESPONSE" != *"key"* ]]; then
  echo "❌ No se pudo obtener el ticket"
  exit 1
fi

echo ""
echo "🧾 TÍTULO:"
echo "$RESPONSE" | grep -m1 '"summary"' | sed 's/.*"summary":"//;s/".*//'

echo ""
echo "📄 DESCRIPCIÓN:"

echo "$RESPONSE" | jq -r '
.fields.description
| ..
| objects
| select(.type? == "text")
| .text
| sed 's/├¡/á/g; s/├│/ó/g; s/├⌐/é/g; s/├║/ú/g; s/ÔÇ£/"/g; s/ÔÇØ/"/g' \
| sed 's/[^[:print:]\t]//g' \
| sed '/^$/d'
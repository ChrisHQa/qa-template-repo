# 🚀 Inicialización del Proyecto QA

Vamos a inicializar el proyecto completo.

---

## Paso 1 - Datos

Preguntar al usuario:

1. Nombre del proyecto
2. Tipo de proyecto:
   - 1: Monorepo
   - 2: Front + Back
   - 3: Solo estructura

Según la opción:

- Si 1 → pedir URL repo
- Si 2 → pedir URL front y back
- Si 3 → no pedir nada más

---

## Paso 2 - Ejecución

Construir el comando usando Git Bash en Windows.

### Monorepo:
```bash
"C:\Program Files\Git\bin\bash.exe" ./scripts/init-project.sh "<PROJECT_NAME>" "1" "<REPO_URL>"

"C:\Program Files\Git\bin\bash.exe" ./scripts/init-project.sh "<PROJECT_NAME>" "2" "<FRONT_URL>" "<BACK_URL>"

"C:\Program Files\Git\bin\bash.exe" ./scripts/init-project.sh "<PROJECT_NAME>" "3"


## Paso 3 - Prompt

Leer y ejecutar:

/agent-context/qa-agent-prompt.md
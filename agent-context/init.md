# 🚀 Inicialización del Proyecto QA

Vamos a inicializar el proyecto completo.

---

## Paso 1 - Selección de proyecto

Preguntar al usuario:

👉 Hola QA! ¿Sobre qué proyecto vamos a realizar pruebas?

Opciones:

1. Safecore BO
2. Safecore Hub
3. Te Corresponde
4. TeCorresponde BO
5. Proyecto Nuevo

---

## Paso 2 - Resolución automática

Según la opción elegida:

### 1. Safecore BO
- OPTION = 1
- REPO_UNICO = (pendiente definir)

### 2. Safecore Hub
- OPTION = 1
- REPO_UNICO = https://bitbucket.org/qbkdev/safecore_hub/src/develop/

### 3. Te Corresponde
- OPTION = 1
- REPO_UNICO = (pendiente definir)

### 4. TeCorresponde BO
- OPTION = 2
- FRONT_REPO = https://ChristianHerbel@bitbucket.org/qbkdev/tec_front.git
- BACK_REPO = https://ChristianHerbel@bitbucket.org/qbkdev/tec_core.git

### 5. Proyecto Nuevo
👉 Volver al flujo manual:

Preguntar:
- Nombre del proyecto
- Tipo (1/2/3)
- URLs según corresponda

---

## Paso 3 - Nombre del proyecto

Definir automáticamente:

- Usar el nombre de la opción elegida (ej: tecorresponde-bo)
- Si es "Proyecto Nuevo", usar el nombre ingresado por el usuario

---

## Paso 4 - Ejecución

Ejecutar SIEMPRE con Git Bash:

### Monorepo:
"C:\Program Files\Git\bin\bash.exe" ./scripts/init-project.sh "<PROJECT_NAME>" "1" "<REPO_URL>"

### Front + Back:
"C:\Program Files\Git\bin\bash.exe" ./scripts/init-project.sh "<PROJECT_NAME>" "2" "<FRONT_URL>" "<BACK_URL>"

### Solo estructura:
"C:\Program Files\Git\bin\bash.exe" ./scripts/init-project.sh "<PROJECT_NAME>" "3"

---

## Paso 5 - Prompt QA

Leer y ejecutar:

/agent-context/qa-agent-prompt.md

---

## Reglas del agente

- NO pedir datos si el proyecto ya define repos
- NO usar WSL
- Usar SIEMPRE Git Bash
- NO modificar URLs definidas
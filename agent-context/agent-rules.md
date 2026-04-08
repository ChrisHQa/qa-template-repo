# Reglas del agente QA

Siempre debes:

1. Leer reglas-negocio.md antes de generar test cases
2. Revisar test-cases existentes para evitar duplicados
3. No inventar criterios que no existan en la historia de usuario.
4. Actualizar traceability.md
5. Marcar como NA lo no automatizable
6. Priorizar edge cases y validaciones backend

## Naming Convention Obligatoria

### Test Cases
Formato: TC-<MODULO>-XXX  
Ejemplo: TC-LOGIN-001

Reglas:
- <MODULO> debe ser una palabra corta en mayúsculas (LOGIN, CLAIMS, PAYMENT)
- El número (XXX) debe ser incremental dentro del módulo
- Antes de crear un nuevo test case, revisar los existentes en /qa/test-cases/<JIRA-ID>/
- Usar el siguiente número disponible (no repetir ni saltear sin motivo)

---

### Carpetas de Historias
Formato: JIRA-XXX  
Ejemplo: JIRA-123

Ubicación:
- /qa/test-cases/JIRA-XXX/

---

### Archivos Playwright
Formato: <modulo>.spec.ts  
Ejemplo: login.spec.ts

Reglas:
- Un archivo por módulo
- Reutilizar el archivo si ya existe
- No crear archivos duplicados para el mismo módulo

---

### Tests dentro de Playwright

Formato del nombre del test:

TC-<MODULO>-XXX - <descripción>

Ejemplo:

test('TC-LOGIN-001 - Login exitoso con credenciales válidas', async () => {})

---

### Trazabilidad obligatoria

Cada Test Case debe incluir:

- ID del test case
- Historia Jira asociada
- Archivo de Playwright asociado (o NA)

Y debe registrarse en:
- /qa/traceability.md

---

### Automatización

- Si un test case NO es automatizable → marcar como NA
- Si es automatizable → debe tener referencia a Playwright
- No crear tests automáticos sin test case previo
- NUNCA skypear un test por falla. Los posibles estados deben ser Pass, Fail, Flaky.

---

### Reglas generales

- NO inventar nombres fuera de esta convención
- SIEMPRE reutilizar antes de crear nuevo
- SIEMPRE mantener consistencia entre:
  - nombre del test case
  - nombre del test en código
  - traceability

### Detección de módulo

El módulo debe inferirse a partir de:
- la funcionalidad principal de la historia Jira
- o el nombre del componente/feature en el código

Ejemplo:
- Login → LOGIN
- Gestión de reclamos → CLAIMS  

## Gestión de Reglas de Negocio

- Las reglas de negocio deben ser pocas, claras y relevantes.
- No agregar reglas automáticamente.

Proceso obligatorio:
1. Detectar posible nueva regla
2. Proponerla al usuario
3. Esperar aprobación explícita
4. Recién ahí agregarla al archivo

Formato:
- RN-XXX: Descripción clara y corta

Evitar:
- Reglas redundantes
- Reglas demasiado específicas de un caso puntual
- Reglas obvias ya cubiertas por otras
# Gmail Unread Count Script

Este script verifica periódicamente la cantidad de correos no leídos en tu cuenta de Gmail, guarda el número en un archivo (ideal para Polybar) y envía notificaciones de escritorio.

## Requisitos / Requirements

- Python 3
- `notify-send` (usualmente preinstalado en Linux con entornos gráficos / usually pre-installed on Linux with GUI)
- Una cuenta de Gmail con **Verificación en 2 Pasos** activada.
- Una **Contraseña de Aplicación** (App Password).

## Configuración / Configuration

### 1. Obtener Contraseña de Aplicación / Get App Password

Google ya no permite usar tu contraseña normal para scripts. Debes generar una contraseña específica:

1.  Ve a tu [Cuenta de Google](https://myaccount.google.com/).
2.  Ve a **Seguridad** -> **Verificación en 2 pasos**.
3.  Al final de la página, busca **Contraseñas de aplicaciones**.
4.  Crea una nueva:
    - **App**: "Correo" o "Otra (nombre personalizado)" -> "Polybar Script"
    - **Dispositivo**: "Otro"
5.  Copia la contraseña de 16 caracteres que te da Google.

### 2. Editar el Script / Edit Script

Abre `gmail_check.py` y edita las siguientes variables al inicio:

```python
USERNAME = "tu_correo@gmail.com"
PASSWORD = "pegas_aqui_tu_contraseña_de_aplicacion"
CHECK_INTERVAL_SECONDS = 60 # Tiempo en segundos entre chequeos
OUTPUT_FILE = "/tmp/gmail_unread_count" # Archivo para Polybar
```

## Ejecución / Running

Ejecuta el script con Python 3:

```bash
python3 gmail_check.py
```

## Integración con Polybar / Polybar Integration

En tu configuración de Polybar (`~/.config/polybar/config.ini`), puedes agregar un módulo custom:

```ini
[module/gmail]
type = custom/script
exec = cat /tmp/gmail_unread_count
interval = 5
format-prefix = " "
format-underline = #e60053
```

Asegúrate de que el script de Python se esté ejecutando en segundo plano (puedes agregarlo al inicio de tu sesión).

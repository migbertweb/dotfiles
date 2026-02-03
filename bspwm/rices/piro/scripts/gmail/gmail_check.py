import imaplib
import time
import os
import subprocess
from datetime import datetime

# ==============================================================================
# CONFIGURACION / CONFIGURATION
# ==============================================================================

# Credenciales de Gmail / Gmail Credentials
# IMPORTANTE: Reemplaza con tu correo y tu Contraseña de Aplicación (App Password)
# IMPORTANT: Replace with your email and App Password
USERNAME = "migbert.yanez@gmail.com"
PASSWORD = "qjut luxd tpwk barg"

# Archivo donde se guardará la cantidad de no leídos (para Polybar)
# File to store the unread count (for Polybar usage)
OUTPUT_FILE = "~/.tmp/gmail_unread_count"

# Tiempo de espera entre verificaciones en segundos
# Time to wait between checks in seconds
CHECK_INTERVAL_SECONDS = 60

# ==============================================================================
# FUNCIONES / FUNCTIONS
# ==============================================================================

def get_unread_count(username, password):
    """
    Conecta a Gmail via IMAP y obtiene la cantidad de correos no leídos.
    Connects to Gmail via IMAP and gets the unread email count.
    """
    try:
        # Conectar al servidor IMAP de Gmail / Connect to Gmail IMAP server
        mail = imaplib.IMAP4_SSL("imap.gmail.com")
        
        # Iniciar sesión / Login
        mail.login(username, password)
        
        # Seleccionar la bandeja de entrada (Inbox) / Select Inbox
        mail.select("inbox")
        
        # Buscar correos no leídos / Search for unread emails
        # 'UNSEEN' es el criterio de búsqueda para no leídos
        status, messages = mail.search(None, "UNSEEN")
        
        if status != "OK":
            return None
            
        # messages[0] contiene los IDs de los mensajes separados por espacio
        # messages[0] contains message IDs separated by space
        unread_msg_ids = messages[0].split()
        
        # Logout
        mail.close()
        mail.logout()
        
        return len(unread_msg_ids)
        
    except Exception as e:
        print(f"Error al verificar correos: {e}")
        return None

def update_file(filepath, count):
    """
    Escribe la cantidad de correos no leídos en un archivo.
    Writes the unread count to a file.
    """
    try:
        file_path = os.path.expanduser('~/.tmp/gmail_unread_count')
        # Crear la carpeta .tmp si no existe
        os.makedirs(os.path.dirname(file_path), exist_ok=True)
        # Guardar el archivo
        with open(file_path, 'w') as f:
            f.write(str(count))
    except Exception as e:
        print(f"Error al escribir archivo: {e}")

def send_notification(count):
    """
    Envía una notificación del sistema usando notify-send.
    Sends a system notification using notify-send.
    """
    try:
        # Solo notificar si hay correos no leídos
        # Only notify if there are unread emails
        if count > 0:
            summary = "Gmail"
            body = f"Tienes {count} correos no leídos."
            subprocess.run(["notify-send", summary, body])
    except Exception as e:
        print(f"Error al enviar notificación: {e}")

def main():
    print(f"Iniciando monitor de Gmail... Verificando cada {CHECK_INTERVAL_SECONDS} segundos.")
    print(f"Starting Gmail monitor... Checking every {CHECK_INTERVAL_SECONDS} seconds.")
    
    last_count = -1
    
    while True:
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        print(f"[{timestamp}] Verificando... / Checking...")
        
        count = get_unread_count(USERNAME, PASSWORD)
        
        if count is not None:
            print(f"Correos no leídos / Unread emails: {count}")
            
            # Actualizar archivo para Polybar / Update file for Polybar
            update_file(OUTPUT_FILE, count)
            
            # Enviar notificación si la cantidad cambió y es mayor a 0, o simplemente cada vez que haya > 0
            # Aquí notificamos cada vez que se detectan > 0, puedes ajustar la lógica
            # We notify every time > 0 is detected.
            if count > 0:
                 send_notification(count)
        else:
            print("No se pudo obtener la cuenta. / Could not retrieve count.")
            update_file(OUTPUT_FILE, "0")

        # Esperar X segundos antes de la próxima verificación
        # Wait X seconds before next check
        time.sleep(CHECK_INTERVAL_SECONDS)

if __name__ == "__main__":
    main()

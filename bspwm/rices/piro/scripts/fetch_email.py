#!/usr/bin/env python3
import imaplib
import email
import json
import os
import time
from email.header import decode_header
from dotenv import load_dotenv

# Cargar variables de .env_email
load_dotenv('.env_email')

EMAIL_USER = os.getenv('EMAIL_USER')
EMAIL_PASS = os.getenv('EMAIL_PASS')
IMAP_SERVER = os.getenv('IMAP_SERVER', 'imap.gmail.com')
IMAP_PORT = int(os.getenv('IMAP_PORT', 993))
REFRESH_INTERVAL = int(os.getenv('REFRESH_INTERVAL', 300))  # segundos

CACHE_DIR = os.path.expanduser('~/.cache')
CACHE_FILE = os.path.join(CACHE_DIR, 'emails.json')

if not os.path.exists(CACHE_DIR):
    os.makedirs(CACHE_DIR)

def clean_text(text):
    if not text:
        return ""
    parts = decode_header(text)
    result = ''
    for part, encoding in parts:
        if isinstance(part, bytes):
            result += part.decode(encoding if encoding else 'utf-8', errors='ignore')
        else:
            result += part
    return result

def fetch_emails():
    data = {
        "new_emails": 0,
        "emails": []
    }

    try:
        mail = imaplib.IMAP4_SSL(IMAP_SERVER, IMAP_PORT)
        mail.login(EMAIL_USER, EMAIL_PASS)
        mail.select("inbox")

        status, response = mail.search(None, 'UNSEEN')
        unread_msg_nums = response[0].split()
        data['new_emails'] = len(unread_msg_nums)

        for num in unread_msg_nums[:10]:
            status, msg_data = mail.fetch(num, '(BODY.PEEK[])')
            for response_part in msg_data:
                if isinstance(response_part, tuple):
                    msg = email.message_from_bytes(response_part[1])
                    sender = clean_text(msg.get('From'))
                    subject = clean_text(msg.get('Subject'))
                    data['emails'].append({
                        "from": sender,
                        "subject": subject
                    })

        mail.logout()

    except Exception as e:
        data['error'] = str(e)

    # Guardar JSON
    with open(CACHE_FILE, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

if __name__ == "__main__":
    print(f"Script de emails iniciado. Actualizando cada {REFRESH_INTERVAL} segundos...")
    while True:
        fetch_emails()
        time.sleep(REFRESH_INTERVAL)

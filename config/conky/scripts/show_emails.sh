#!/usr/bin/env bash
CACHE_FILE="$HOME/.cache/emails.json"
MAX_SUBJECT_LEN=30  # Ajusta a lo que quieras

if [[ ! -f "$CACHE_FILE" ]]; then
    echo "No hay correos nuevos"
    exit 0
fi

new_emails=$(jq '.new_emails' "$CACHE_FILE")

if [[ "$new_emails" -eq 0 ]]; then
    echo "No hay correos nuevos"
    exit 0
fi

# Mostrar cantidad de correos nuevos
echo -e "Nuevos correos: $new_emails"

# Recorrer todos los correos nuevos
jq -r '.emails[] | "\(.from)\n\(.subject)"' "$CACHE_FILE" | while IFS= read -r line_from && IFS= read -r line_subject; do
    # Recortar asunto si es muy largo
    if [[ ${#line_subject} -gt $MAX_SUBJECT_LEN ]]; then
        line_subject="${line_subject:0:$MAX_SUBJECT_LEN}"
    fi
    # Imprimir
    echo -e "${color3}$line_from\n$line_subject"
done

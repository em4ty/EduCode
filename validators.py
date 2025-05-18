from datetime import datetime
import re

def validate_date(date_str):
    """Валидация даты в формате YYYY-MM-DD"""
    if not date_str:
        return False
    try:
        datetime.strptime(date_str, '%Y-%m-%d')
        return True
    except ValueError:
        return False

def validate_phone(phone_str):
    """Валидация российского номера телефона"""
    if not phone_str:
        return False
    pattern = r'^(\+7|8)\d{10}$'
    cleaned = re.sub(r'[^\d+]', '', phone_str)
    return bool(re.fullmatch(pattern, cleaned))
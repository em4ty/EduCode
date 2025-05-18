import unittest
from datetime import datetime
import re
from validators import *

class TestUserInputs(unittest.TestCase):
    
    def test_date_validation(self):
    
        test_cases = [
            # (input, expected, test_description)
            ("2023-12-31", True, "Корректная дата"),
            ("31-12-2023", False, "Неправильный формат даты"),
            ("2023-02-30", False, "Несуществующая дата"),
            ("", False, "Пустая строка"),
            (None, False, "None значение")
        ]
        
        for date_input, expected, description in test_cases:
            with self.subTest(description):
                try:
                    result = validate_date(date_input)
                    self.assertEqual(result, expected)
                except Exception as e:
                    self.fail(f"Тест '{description}' вызвал исключение: {str(e)}")

    def test_phone_validation(self):
   
        test_cases = [
            # (input, expected, test_description)
            ("+79161234567", True, "Корректный российский номер"),
            ("89161234567", True, "Номер без +7"),
            ("12345", False, "Слишком короткий номер"),
            ("+7(916)123-45-67", False, "Неправильный формат"),
            ("abcdefg", False, "Нечисловые символы"),
            ("", False, "Пустая строка")
        ]
        
        for phone_input, expected, description in test_cases:
            with self.subTest(description):
                try:
                    result = validate_phone(phone_input)
                    self.assertEqual(result, expected)
                except Exception as e:
                    self.fail(f"Тест '{description}' вызвал исключение: {str(e)}")
if __name__ == '__main__':
    unittest.main()

﻿Функция Расш66_ПолучитьЦвет(СсылкаКассаККМ) Экспорт
	ЦветЗаголовка = Неопределено;	
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	КассыККМ.Расш66_ЦветЗаголовка КАК ЦветЗаголовка
		|ИЗ
		|	Справочник.КассыККМ КАК КассыККМ
		|ГДЕ
		|	КассыККМ.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", СсылкаКассаККМ);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		ЦветЗаголовка = Выборка.ЦветЗаголовка.Получить();
	КонецЕсли;
		
	Возврат ЦветЗаголовка;
КонецФункции

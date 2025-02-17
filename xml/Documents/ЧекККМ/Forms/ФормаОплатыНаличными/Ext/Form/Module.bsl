﻿
&НаКлиенте
Процедура Расш66_ПробитьБезККТПосле(Команда)
	// Делаю в фикс.стуруктуре парамерт ИспользоватьБезПодключенияОборудования = Истина 
	НоваяСтруктура = Новый Структура;
	ПараметрыКассыККМ = ЭтаФорма.ВладелецФормы.ПараметрыКассыККМ;
	Для Каждого Элемент Из ПараметрыКассыККМ Цикл
		Если Элемент.Ключ = "ИспользоватьБезПодключенияОборудования" Тогда 
			НоваяСтруктура.Вставить(Элемент.Ключ, Истина);
		Иначе
		   	НоваяСтруктура.Вставить(Элемент.Ключ, Элемент.Значение);
		КонецЕсли;
	КонецЦикла;
	//НовыйФиксСтруктура  = Новый ФиксированнаяСтруктура(НоваяСтруктура);
	//ЭтаФорма.ВладелецФормы.ПараметрыКассыККМ = НовыйФиксСтруктура;
	ЭтаФорма.ВладелецФормы.ПараметрыКассыККМ = НоваяСтруктура;
	// Продолжим стандартное выполнение пробития чека
	КомандаПробитьЧек(Команда)
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
&После("РассчитатьИтоги")
Процедура Расш66_РассчитатьИтоги(Форма)
	// Добавим доступность оплаты без чека
	Если Форма.СуммаОплаты >= Форма.КОплате Тогда
		Форма.Элементы.КнопкаДекорация.Доступность = Истина;
	Иначе
		Форма.Элементы.КнопкаДекорация.Доступность = Ложь;
	КонецЕсли;

КонецПроцедуры

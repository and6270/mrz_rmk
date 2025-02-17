﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	МассивРМ = Обработки.Расш66_ИзменениеКассыККМНаРабочихМестах.ПолучитьТекущиеКассыККМПоСкладам();
	Сч = 1;
	Для Каждого Склад Из МассивРМ Цикл
		
		//Добавить поле склад, сколько рабочих мест и какая выбрана
		ДобавляемыеРеквизиты = Новый Массив;
		ТипСтрока = Новый ОписаниеТипов("Строка",,,,Новый КвалификаторыСтроки(100));
		НовРеквизит = Новый РеквизитФормы("КассыККМ"+Сч, ТипСтрока);
		ДобавляемыеРеквизиты.Добавить(НовРеквизит);
		
		НовРеквизит = Новый РеквизитФормы("РабочиеМеста"+Сч, Новый ОписаниеТипов("СписокЗначений"));
		ДобавляемыеРеквизиты.Добавить(НовРеквизит);
		ИзменитьРеквизиты(ДобавляемыеРеквизиты);
		
		//добавим декорацию
		ЭлементДекорация = Элементы.Добавить("Декорация" +Сч, Тип("ДекорацияФормы"),ЭтаФорма);
		ЭлементДекорация.Заголовок = "Склад: " + Склад.Склад + Символы.ПС
									+ "Касса ККМ: " + Склад.КассыККМ[0].Касса + Символы.ПС
									+ "Рабочих мест: " + Склад.КассыККМ[0].Счетчик;
		
		//добавить поле переключателя на все кассы ккм по тек.складу
		НовЭлемент = Элементы.Добавить("КассыККМ"+Сч, Тип("ПолеФормы"), ЭтаФорма);
		НовЭлемент.ПутьКДанным = "КассыККМ"	+ Сч;
		НовЭлемент.Заголовок = "Установить кассу ККМ";
		НовЭлемент.Вид = ВидПоляФормы.ПолеПереключателя;
		НовЭлемент.ВидПереключателя = ВидПереключателя.Тумблер;
		Для н=0 По Склад.КассыККМ.Количество()-1 Цикл
			НовЭлементСпискаВыбора = НовЭлемент.СписокВыбора.Добавить();
			НовЭлементСпискаВыбора.Представление = Строка(Склад.КассыККМ[н].Касса); 
			НовЭлементСпискаВыбора.Значение = Строка(Склад.КассыККМ[н].Касса);
		КонецЦикла;
		НовЭлемент.УстановитьДействие("ПриИзменении", "СкладПриИзменении");
		//НовЭлемент.Списоквыбора 
		Для Каждого РабочееМесто Из Склад.РабочиеМеста Цикл
			НовЗначение = ЭтотОбъект["РабочиеМеста"+Сч].Добавить();	
			НовЗначение.Значение = РабочееМесто;
		КонецЦикла;
		
		ЭлементТаблица = Элементы.Добавить("РабочиеМеста"+Сч, Тип("ТаблицаФормы"), ЭтаФорма);
		ЭлементТаблица.ПутьКДанным = "РабочиеМеста"	+ Сч;
		ЭлементТаблица.КоманднаяПанель.Видимость = Ложь;
		КолонкаЗначение = Элементы.Добавить("Значение", Тип("ПолеФормы"),ЭлементТаблица);
		КолонкаЗначение.ПутьКДанным = "РабочиеМеста"+Сч + ".Значение";
		Сч = Сч + 1;	
	КонецЦикла;
		
КонецПроцедуры 

&НаКлиенте
Процедура КассыККМПриИзменении(Элемент)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура СкладПриИзменении(Элемент)
	Сч = Число(Сред(Элемент.Имя,9)); 
	МассивРабочихМест = Новый Массив;
	Для каждого РМ Из ЭтотОбъект["РабочиеМеста"+Сч] Цикл
		МассивРабочихМест.Добавить(РМ.Значение);		
	КонецЦикла;
	
	КассаККМ = ЭтотОбъект["КассыККМ" + Сч];
	СкладПриИзмененииНаСервере(КассаККМ,МассивРабочихМест);
	ПоказатьОповещениеПользователя("Рабочие места настроены");
	Закрыть();
КонецПроцедуры

&НаСервереБезКонтекста
Процедура СкладПриИзмененииНаСервере(КассаККМ,МассивРабочихМест)
	Обработки.Расш66_ИзменениеКассыККМНаРабочихМестах.УстановитьКассуККМПоУмолчанию(КассаККМ,МассивРабочихМест);
КонецПроцедуры



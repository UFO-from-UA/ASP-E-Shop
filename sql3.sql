--v6
CREATE TABLE InfoDetails
(
InfoDetailsId int IDENTITY(1, 1) PRIMARY KEY not null,
ImgSource nvarchar(300),  --мб не макс
UrlImgSource nvarchar(300) , --мб не макс
HtmlData nvarchar(MAX)
)

CREATE TABLE Details
(
DetailsId int IDENTITY(1, 1) PRIMARY KEY not null,
MainInfo nvarchar(2000) --мб не макс
)

CREATE TABLE MenuDetails
(
MenuDetailsId int IDENTITY(1, 1) PRIMARY KEY not null,
MenuName nvarchar(200),
Id_InfoDetails int FOREIGN KEY REFERENCES InfoDetails(InfoDetailsId),
--Many MenuDetails to one Details by   MenuDetails.Id_Details = Details.Id
Id_Details int FOREIGN KEY REFERENCES Details(DetailsId)
)

CREATE TABLE MainCategory
( MainCategoryId int IDENTITY(1, 1) PRIMARY KEY not null,
MainCategoryName nvarchar(200)
)

INSERT INTO MainCategory values('Измерители-регуляторы')
INSERT INTO MainCategory values('Приборы контроля и управления')
INSERT INTO MainCategory values('Программируемые реле')
INSERT INTO MainCategory values('Программируемые логические контроллеры')
INSERT INTO MainCategory values('Сенсорные панельные контроллеры')
INSERT INTO MainCategory values('Панели оператора')
INSERT INTO MainCategory values('Модули ввода/вывода')
INSERT INTO MainCategory values('Устройства связи')

INSERT INTO MainCategory values('Приводная техника')
INSERT INTO MainCategory values('Блоки питания и устройства коммутации')
INSERT INTO MainCategory values('Датчики')
INSERT INTO MainCategory values('Программное обеспечение')

INSERT INTO MainCategory values('Архив продукции')
INSERT INTO MainCategory values('Электротехническое оборудование Meyertec ')

CREATE TABLE Category
( CategoryId int IDENTITY(1, 1) PRIMARY KEY not null,
CategoryName nvarchar(200)
)

INSERT INTO Category values('Измерители')
INSERT INTO Category values('Регуляторы')
INSERT INTO Category values('ПИД-регуляторы')
INSERT INTO Category values('Контроллеры для систем вентиляции, отопления и ГВС')
INSERT INTO Category values('Программные задатчики')
INSERT INTO Category values('Нормирующие преобразователи')
INSERT INTO Category values('Архиваторы')
INSERT INTO Category values('Измерители параметров электрической сети')
INSERT INTO Category values('Приборы для холодильной техники')

CREATE TABLE Product
(
Id int IDENTITY(1, 1) PRIMARY KEY not null,
Id_MainCategory int ,
Id_Category int,
Id_Details int,
ShortName nvarchar(50),
[Name] nvarchar(300),
ImgSource nvarchar(300),
CONSTRAINT [FK_MainCategory] FOREIGN KEY (Id_MainCategory) REFERENCES MainCategory(MainCategoryId),
CONSTRAINT [FK_Category] FOREIGN KEY (Id_Category) REFERENCES Category(CategoryId),
CONSTRAINT [FK_Details] FOREIGN KEY (Id_Details) REFERENCES Details(DetailsId)
)


INSERT INTO Details values('Прибор является продолжением линейки измерителей 2ТРМ0, с RS-485. Используется для фиксирования физических величин и перевода их из аналогового в цифровой сигнал. Особенностью этой модели является наличие интерфейса RS-485, что дает возможность:- подключать ТРМ200 к компьютеру с помощью протокола компании ОВЕН (Modbus ASCII/RTU прилагается);- передавать в сеть полученные данные, а также связанные с ними программированные параметры.')
INSERT INTO InfoDetails values('empty','empty URL','Назначение измерительного прибора ОВЕН ТРМ200
Прибор ОВЕН ТРМ200 (аналог ОВЕН 2ТРМ0 с интерфейсом RS-485) – двухканальный измеритель, применяемый для измерения температуры, уровня, давления, влажности, веса и других физических параметров теплоносителей и различных сред (в зависимости от подключенных датчиков). Измерительный прибор ОВЕН ТРМ200 предназначен для использования в холодильных установках, сушильных шкафах, печах, пастеризаторах и на другом технологическом оборудовании. Измерительный прибор выпускается в корпусах 4-х типов: настенных Н, Н2 и щитовых Щ1, Щ2.
Функциональные возможности прибора ОВЕН ТРМ200
Измеритель ОВЕН ТРМ 200 имеет два универсальных входа для подключения широкого спектра датчиков (температуры, давления, уровня и других физических параметров). Входы обеспечивают возможность подключения датчиков разных типов
Измеритель ОВЕН ТРМ 200 имеет функции цифровой фильтрации и коррекции входного сигнала, а также масштабирования шкалы для аналогового входа
Вычисление разности измеряемых величин
Индикация текущих значений измеренных величин и их разности на двух встроенных 4-х разрядных светодиодных цифровых индикаторах
Вычисление и индикация квадратного корня из измеряемой величины (например, для измерения мгновенного расхода)
Встроенный интерфейс RS-485 (протокол ОВЕН, Modbus ASCII/RTU)
В измерительном приборе предусмотрены различные уровни защиты настроек прибора для разных групп специалистов
Конфигурирование измерителя-регулятора осуществляется на ПК или с лицевой панели прибора
Вы можете скачать бесплатно ПО для прибора ОВЕН ТРМ200: ОРС-сервер, драйвер для работы со SCADA-системой TRACE MODE, библиотеки WIN DLL')
INSERT INTO MenuDetails values('Описание',(SELECT MAX(InfoDetailsId) FROM InfoDetails),1)

CREATE TABLE PriceDetails
(
PriceDetailsId int IDENTITY(1, 1) PRIMARY KEY not null,
Id_Product int ,
Marks nvarchar(300),
Price money,
CONSTRAINT [FK_PriceDetails_Product] FOREIGN KEY (Id_Product) REFERENCES Product(Id)
)

INSERT INTO Product values(1,1,1,'ТРМ200','ТРМ200. Измеритель двухканальный с RS-485','https://owen.ua/thumbs/79/trm200-n--___1bd42272-450x450-d.jpg')
INSERT INTO PriceDetails values(1,'Щ2',1764.00)
INSERT INTO PriceDetails values(1,'Щ1',1764.00)
INSERT INTO PriceDetails values(1,'Н',1764.00)
INSERT INTO PriceDetails values(1,'Н2',2196.00)

--- инсерт  с  предидущей
INSERT INTO InfoDetails values('empty','empty URL','<p><strong>Питание</strong></p><table><tbody class="InfoDetailsTableCells"><tr><td>Напряжение питания</td><td>90&hellip;245 В переменного тока</td></tr><tr><td>Частота напряжения питания</td><td>47...63 Гц</td></tr></tbody>
</table><p>&nbsp;<strong>Универсальные входы</strong></p><table ><tbody class="InfoDetailsTableCells"><tr><td>Количество универсальных входов</td><td>2</td></tr><tr><td>Типы входных датчиков и сигналов</td><td>см. таблицу &laquo;Характеристики измерительных датчиков&raquo;</td></tr><tr><td>Время опроса входа</td><td>1 с</td></tr><tr><td colspan="2">Входное сопротивление при подключении источника сигнала:&nbsp;</td></tr><tr><td>&ndash; тока</td><td>100 Ом &plusmn; 0,1 % (при подключении внешнего резистора)</td></tr><tr><td>&ndash; напряжения</td><td>не менее 100 кОм</td></tr><tr><td colspan="2" >&nbsp;Предел допустимой основной погрешности:</td></tr><tr><td>&ndash; при использовании термопреобразователя сопротивления</td><td>&plusmn;0,5 %</td></tr><tr><td>&ndash; для остальных видов сигналов</td><td>&plusmn;0,25 %</td></tr></tbody>
</table>
<p><strong>Интерфейс связи</strong></p>
<table ><tbody class="InfoDetailsTableCells"><tr><td>Тип интерфейса</td><td>RS-485</td></tr><tr><td>Скорость передачи данных</td><td>2.4; 4.8; 9.6; 14.4; 19.6; 28.8; 38.4; 57.6; 115.2 кбит/с</td></tr><tr><td>Тип кабеля</td><td>экранированная витая пара</td></tr></tbody></table><p><strong>Корпус</strong></p><table ><tbody class="InfoDetailsTableCells"><tr><td colspan="2" >Габаритные размеры и степень защиты корпуса</td></tr><tr><td>Щитовой Щ1</td><td>96х96х70 мм, IP54*</td></tr><tr><td>Щитовой Щ2</td><td>96х48х100 мм, IP54*</td></tr><tr><td>Настенный Н</td><td>130х105х65 мм, IP44</td></tr><tr><td>Настенный Н2</td><td>150х105х35 мм, IP20</td></tr><tr><td colspan="2">* со стороны передней панели</td></tr>
</tbody>
</table>
<p><strong>Характеристики измерительных датчиков</strong></p>

<table>
<tbody class="InfoDetailsTableCells">
</tr><td>Код in.t1(2)</td>  <td>Тип датчика</td>  <td>Диапазон измерений</td>  </tr>
</tr><td>r385</td>  <td>ТСП 50П W100 = 1.385</td>  <td>–200…+750 °С</td>  </tr>
</tr><td>r.385</td>  <td>ТСП 100П W100 = 1.385 (Pt 100)</td>  <td>–200…+750 °С</td>  </tr>
</tr><td>r391</td>  <td>ТСП 50П W100 = 1.391</td>  <td>–200…+750 °С</td>  </tr>
</tr><td>r.391</td>  <td>ТСП 100П W100 = 1.391</td>  <td>–200…+750 °С</td>  </tr>
</tr><td>r-21</td>  <td>ТСП гр. 21 (R0=46 Oм, W100 = 1.391)</td>  <td>–200…+750 °С</td>  </tr>
</tr><td>r426</td>  <td>ТСМ 50М W100 = 1.426</td>  <td>–50…+200 °С</td>  </tr>
</tr><td>r.426</td>  <td>ТСМ 100М W100 = 1.426</td>  <td>–50…+200 °С</td>  </tr>
</tr><td>r-23</td>  <td>ТСМ гр. 23 (R0=53 Ом, W100 = 1.426)</td>  <td>–50…+200 °С</td>  </tr>
</tr><td>r428</td>  <td>ТСМ 50М W100 = 1.428</td>  <td>–190…+200 °С</td>  </tr>
</tr><td>r.428</td>  <td>ТСМ 100М W100 = 1.428</td>  <td>–190…+200 °С</td>  </tr>
</tr><td>E_A1</td>  <td>термопара ТВР (А-1)</td>  <td>0…+2500 °С</td>  </tr>
</tr><td>E_A2</td>  <td>термопара ТВР (А-2)</td>  <td>0…+1800 °C</td>  </tr>
</tr><td>E_A3</td>  <td>термопара ТВР (А-3)</td>  <td>0…+1800 °C</td>  </tr>
</tr><td>E_ _b</td>  <td>термопара ТПР (В)</td>  <td>+200…+1800 °C</td>  </tr>
</tr><td>E_ _J</td>  <td>термопара ТЖК (J)</td>  <td>–200…+1200 °С</td>  </tr>
</tr><td>E_ _K</td>  <td>термопара ТХА (K)</td>  <td>–200…+1300 °С</td>  </tr>
</tr><td>E_ _L</td>  <td>термопара ТХК (L)</td>  <td>–200…+800 °С</td>  </tr>
</tr><td>E_ _n</td>  <td>термопара ТНН (N)</td>  <td>–200…+1300 °С</td>  </tr>
</tr><td>E_ _r</td>  <td>термопара ТПП (R)</td>  <td>0…+1750 °C</td>  </tr>
</tr><td>E_ _S</td>  <td>термопара ТПП (S)</td>  <td>0…+1750 °C</td>  </tr>
</tr><td>E_ _t</td>  <td>термопара ТМК (Т)</td>  <td>–200…+400 °C</td>  </tr>
</tr><td>i 0_5</td>  <td>ток 0…5 мА</td>  <td>0…100 %</td>  </tr>
</tr><td>i 0.20</td>  <td>ток 0…20 мA</td>  <td>0…100 %</td>  </tr>
</tr><td>i 4.20</td>  <td>ток 4…20 мА</td>  <td>0…100 %</td>  </tr>
</tr><td>U-50</td>  <td>напряжение –50…+50 мВ</td>  <td>0…100 %</td>  </tr>
</tr><td>U0_1</td>  <td>напряжение 0…1 В</td>  <td>0…100 %</td>  </tr>
</tbody>
</table>')
INSERT INTO MenuDetails values('Технические характеристики',(SELECT MAX(InfoDetailsId) FROM InfoDetails),1)
INSERT INTO InfoDetails values('empty','https://owen.ua/uploads/24/trm-200-rs485.jpg','<p><em><img style="display: block; margin-left: auto; margin-right: auto;" src="https://owen.ua/uploads/24/trm-200-rs485.jpg" alt="Измеритель двухканальный с RS-485 ОВЕН ТРМ200. Функциональная схема" width="450" height="401" /></em></p>
<p style="text-align: center;"><em>Измеритель двухканальный с RS-485 ОВЕН ТРМ200. Функциональная схема</em></p>')
INSERT INTO MenuDetails values('Функциональная схема',(SELECT MAX(InfoDetailsId) FROM InfoDetails),1)
INSERT INTO InfoDetails values('empty','empty URL','<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://owen.ua/thumbs/86/n-rus___debccd6e-600x0-d.png" alt="Прибор настенного крепления Н" width="600" height="279" /></p>
<p style="text-align: center;"><em>Прибор настенного крепления Н</em></p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://owen.ua/thumbs/86/n2-gabarity-all___91a4300c-600x0-d.png" alt="Прибор настенного крепления Н2" width="600" height="306" /></p>
<p>&nbsp;</p>
<p style="text-align: center;"><em>Прибор настенного крепления Н2</em></p>
<p style="text-align: center;"><em><img src="https://owen.ua/thumbs/86/sch1-rus___2b93497f-600x0-d.png" alt="Прибор щитового крепления Щ1" width="600" height="350" /></em></p>
<p style="text-align: center;"><em>Прибор щитового крепления Щ1</em></p>
<p style="text-align: center;"><em><img src="https://owen.ua/thumbs/86/sch2-rus___7eafca42-600x0-d.png" alt="Прибор щитового крепления Щ2" width="600" height="359" /></em></p>
<p style="text-align: center;"><em>Прибор щитового крепления Щ2</em></p>')
INSERT INTO MenuDetails values('Габаритные и установочные размеры',(SELECT MAX(InfoDetailsId) FROM InfoDetails),1)
INSERT INTO InfoDetails values('empty','https://owen.ua/uploads/24/trm200_rs485-2.jpg','<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://owen.ua/uploads/24/trm200_rs485-2.jpg" alt="Измеритель двухканальный с RS-485 ОВЕН ТРМ200. Схема подключения" width="350" height="391" /></p>
<p style="text-align: center;"><em>Измеритель двухканальный с RS-485 ОВЕН ТРМ200. Схема подключения</em></p>')
INSERT INTO MenuDetails values('Схемы подключения',(SELECT MAX(InfoDetailsId) FROM InfoDetails),1)
INSERT INTO InfoDetails values('empty','empty URL','<p style="text-align: center;"><img src="https://owen.ua/uploads/79/trm200-obozn.svg" alt=" width="655" height="252" /></p>')
INSERT INTO MenuDetails values('Обозначение при заказе',(SELECT MAX(InfoDetailsId) FROM InfoDetails),1)
INSERT INTO InfoDetails values('empty','empty URL','<ol>
<li>Прибор ТРМ200</li>
<li>Комплект крепежных элементов (Н или Щ, в зависимости от типа корпуса)</li>
<li>Паспорт и Гарантийный талон</li>
<li>Руководство по эксплуатации</li>
</ol>')
INSERT INTO MenuDetails values('Комплектность',(SELECT MAX(InfoDetailsId) FROM InfoDetails),1)
INSERT INTO InfoDetails values('empty','empty URL','
<table >
<tbody  class="InfoDetailsTableCells">
<tr >
<td >Программное обеспечение</td>
<td>UA</td>
<td>RU</td>
</tr>
<tr>
<td>Конфигуратор ТРМ2xx</td>
<td>&nbsp;</td>
<td><a href="/Product/DownloadFiles?fileName=setup_tpm101_tpm2xx_3.0.5&amp;fileExtention=.zip">Скачать</a></td>
</tr>
</tbody>
</table>');
INSERT INTO MenuDetails values('Программное обеспечение',(SELECT MAX(InfoDetailsId) FROM InfoDetails),1)
INSERT INTO InfoDetails values('empty','empty URL','<table style="height: 53px; width: 583px; margin-left: auto; margin-right: auto;" border="2">
<tbody>
<tr style="background-color: #aaa;"><td style="width: 411px;">Документ</td><td style="width: 70px; text-align: center;">UA</td><td style="width: 144px; text-align: center;">RU</td></tr><tr><td style="width: 411px;"> Руководство по эксплуатации ТРМ200</td><td style="width: 70px; text-align: center;">&nbsp;<a href="/Product/DownloadFiles?fileName=re_oven_trm200_0034_ua&amp;fileExtention=.pdf">Скачать</a></td><td style="width: 144px; text-align: center;">Скачать</td></tr><tr><td style="width: 411px;">Параметры ТРМ200</td><td style="width: 70px; text-align: center;">&nbsp;</td><td style="width: 144px; text-align: center;">Скачать</td></tr><tr><td style="width: 411px;">Декларация о соответствии ОВЕН 2ТРМх, ТРМ1, ТРМ1х, ТРМ2хх, ТРМ1хх, УКТ38, ТРМ148, ТРМ151, ТРМ251, МПР51</td><td style="width: 70px; text-align: center;">Скачать</td><td style="width: 144px; text-align: center;">&nbsp;</td></tr><tr><td style="width: 411px;">Сертификат утверждения типа СИТ ОВЕН ТРМххх</td><td style="width: 70px; text-align: center;">Скачать</td><td style="width: 144px; text-align: center;">&nbsp;</td></tr></tbody>
</table>')
INSERT INTO MenuDetails values('Документация',(SELECT MAX(InfoDetailsId) FROM InfoDetails),1)
INSERT INTO InfoDetails values('empty','empty URL','В разработке')
INSERT INTO MenuDetails values('Проектировщику в помощь',(SELECT MAX(InfoDetailsId) FROM InfoDetails),1)
INSERT INTO InfoDetails values('empty','empty URL','Отдельный PartialView')
INSERT INTO MenuDetails values('Цены',(SELECT MAX(InfoDetailsId) FROM InfoDetails),1)
-------------------------------------- 2ТРМ0 --------------------------------------
INSERT INTO Details values('ОВЕН 2ТРМ0 совместно с первичными преобразователями применяется в качестве измерителя различных физических величин, а затем конвертирует аналоговые показатели в цифровой сигнал.Прибор приспособлен к применению в различных промышленных отраслях в области измерения параметров технологических процессов.')
INSERT INTO Product values(1,1,(SELECT MAX(DetailsId) FROM Details),'2ТРМ0','2ТРМ0. Вимірювач двоканальний','https://owen.ua/thumbs/79/2trm0-n-pribor___fed598ff-450x450-d.jpg')
INSERT INTO PriceDetails values((SELECT MAX(Id) FROM Product ),'Щ2.У',1440.00)
INSERT INTO PriceDetails values((SELECT MAX(Id) FROM Product ),'Д.У',1440.00)
INSERT INTO PriceDetails values((SELECT MAX(Id) FROM Product ),'Щ11.У',1440.00)
INSERT INTO PriceDetails values((SELECT MAX(Id) FROM Product ),'Щ1.У',1440.00)
INSERT INTO PriceDetails values((SELECT MAX(Id) FROM Product ),'Н.У',1440.00)
INSERT INTO InfoDetails values('empty','empty URL','<h3><strong>Главные преимущества нового 2ТРМ0</strong></h3>
<ul><li>Улучшенная помехоустойчивость: новый 2ТРМ0 полностью соответствует требованиям ДСТУ IEC 61326-1 по электромагнитной совместимости для оборудования класса А (для промышленных зон) с критерием качества функционирования А</li><li>Повышенная надежность: наработка на отказ составляет 100 000 часов</li><li>Повышенная точность измерений: погрешность измерений не превышает 0,15 % (при классе точности 0,25/0,5)</li><li>Увеличенный межповерочный интервал: межповерочный интервал &ndash; 3 года</li><li>Увеличенный срок гарантии: гарантийный срок обслуживания нового 2ТРМ0 составляет 5 лет</li><li>Улучшенные показатели климатического исполнения: допустимый диапазон рабочих температур от &ndash;20 до +50 &deg;С</li><li>Универсальные входы: прибор поддерживает все наиболее распространенные типы датчиков</li><li>Расширенный диапазон напряжений питания: 90...245 В частотой 47...63 Гц</li><li>Встроенный источник питания 24 В во всех модификациях нового 2ТРМ0 для питания активных датчиков или других низковольтных цепей АСУ</li></ul>
<p>&nbsp;</p>
<h3><strong>Основные функции измерителя двухканального ОВЕН 2ТРМ0</strong></h3>
<ul><li>Два универсальных входа для подключения широкого спектра датчиков температуры, давления, влажности, расхода, уровня и т. п.</li><li>Цифровая фильтрация и коррекция&nbsp;входного сигнала, масштабирование шкалы для аналогового входа</li><li>Вычисление и индикация квадратного корня из измеряемой величины (например, для регулирования мгновенного расхода)</li><li>Вычисление разности двух измеряемых величин (&Delta;Т = Т1 &ndash; Т2)</li><li>Индикация текущих значений измеренных величин Т1,Т2 или их разности на встроенном 4-х разрядном светодиодном цифровом индикаторе</li><li>Импульсный источник питания 90...245 В 47...63 Гц</li><li>Встроенный источник питания&nbsp;24 В для активных датчиков во всех модификациях прибора</li><li>Программирование кнопками на лицевой панели прибора</li><li>Сохранение настроек при отключении питания</li><li>Защита настроек от несанкционированных изменений</li></ul>')
INSERT INTO MenuDetails values('Описание',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','<p><strong>Питание</strong></p>
<table>
<tbody>
<tr><td>Напряжение питания переменного тока</td><td>90&hellip;245 В</td></tr><tr><td>Частота напряжения питания</td><td>47...63 Гц</td></tr><tr><td>Потребляемая мощность</td><td>не более 7 ВА</td></tr><tr><td>Напряжение встроенного источника питания нормирующих преобразователей</td><td>24 &plusmn; 2,4 В</td></tr><tr><td>Максимально допустимый ток источника питания</td><td>80 мА</td></tr></tbody>
</table>
<p><strong>Универсальные входы</strong></p>
<table>
<tbody>
<tr><td>Количество универсальных входов</td><td>2</td></tr><tr><td>Типы входных датчиков и сигналов</td><td>см. таблицу &laquo;Характеристики измерительных датчиков&raquo;</td></tr><tr><td>Время опроса входа:</td><td>&nbsp;</td></tr><tr><td>&ndash; для термопреобразователей сопротивления</td><td>не более 0,8 с</td></tr><tr><td>&ndash; для других датчиков</td><td>не более 0,4 с</td></tr><tr><td>Предел основной приведенной погрешности измерения:</td><td>&nbsp;</td></tr><tr><td>&ndash; для термоэлектрических преобразователей</td><td>&plusmn;0,5 %</td></tr><tr><td>&ndash; для других датчиков</td><td>&plusmn;0,25 %</td></tr></tbody>
</table>
<p><strong>Корпус</strong></p>
<table>
<tbody>
<tr><td colspan=""2"">Габаритные размеры (мм) и степень защиты корпуса</td></tr><tr><td>Щитовой Щ1</td><td>96х96х65, IP54*</td></tr><tr><td>Щитовой Щ2</td><td>96х48х100, IP54*</td></tr><tr><td>Щитовой Щ11</td><td>96х96х47, IP54*</td></tr><tr><td>На DIN рейку</td><td>90х72х58, IP20</td></tr><tr><td>Настенный Н</td><td>130х105х65, IP44</td></tr><tr><td colspan=""2"">* со стороны передней панели</td></tr></tbody>
</table>
<p><strong>Условия эксплуатации</strong></p>
<table>
<tbody>
<tr><td>Температура окружающего воздуха</td><td>&ndash;20...+50 &deg;С</td></tr><tr><td>Атмосферное давление</td><td>84...106,7 кПа</td></tr><tr><td>Относительная влажность воздуха (при +35 &deg;С и ниже без конденсации влаги)</td><td>30...80 %</td></tr></tbody>
</table>
<p><strong>&nbsp;Характеристики измерительных датчиков</strong></p>
<table>
<tbody>
<tr><td>Код b1-0</td><td>Тип датчика</td><td>Диапазон измерений</td><td>Разрешающая способность*</td></tr><tr><td>1</td><td>ТСМ (Cu50) W100=1.426</td><td>&ndash;50&hellip;+200 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>9</td><td>ТСМ (50М) W100=1.428</td><td>&ndash;200&hellip;+200 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>7</td><td>ТСП (Pt50) W100=1.385</td><td>&ndash;200&hellip;+850 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>8</td><td>ТСП (50П) W100=1.391</td><td>&ndash;240&hellip;+1100 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>0</td><td>ТСМ (Cu100) W100=1.426</td><td>&ndash;50&hellip;+200 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>14</td><td>ТСМ (100М) W100=1.428</td><td>&ndash;200&hellip;+200 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>2</td><td>ТСП (Pt100) W100=1.385</td><td>&ndash;200&hellip;+850 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>3</td><td>ТСП (100П) W100=1.391</td><td>&ndash;240&hellip;+1100 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>29</td><td>ТСН (100Н) W100=1.617</td><td>&ndash;60&hellip;+180 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>30</td><td>ТСМ (Cu500) W100=1.426</td><td>&ndash;50&hellip;+200 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>31</td><td>ТСМ (500М) W100=1.428</td><td>&ndash;200&hellip;+200 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>32</td><td>ТСП (Pt500) W100=1.385</td><td>&ndash;200&hellip;+850 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>33</td><td>ТСП (500П) W100=1.391</td><td>&ndash;250&hellip;+1100 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>34</td><td>ТСН (500Н) W100=1.617</td><td>&ndash;60&hellip;+180 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>35</td><td>ТСМ (Cu1000) W100=1.426</td><td>&ndash;50&hellip;+200 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>36</td><td>ТСМ (1000М) W100=1.428</td><td>&ndash;200&hellip;+200 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>37</td><td>ТСП (Pt1000) W100=1.385</td><td>&ndash;200&hellip;+850 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>38</td><td>ТСП (1000П) W100=1.391</td><td>&ndash;250&hellip;+1100 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>39</td><td>ТСН (1000Н) W100=1.617</td><td>&ndash;60&hellip;+180 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>15</td><td>ТСМ (53М) W100=1.426 (гр. 23)</td><td>&ndash;50&hellip;+200 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>4</td><td>термопара ТХК (L)</td><td>&ndash;200&hellip;+800 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>20</td><td>термопара ТЖК (J)</td><td>&ndash;200&hellip;+1200 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>19</td><td>термопара ТНН (N)</td><td>&ndash;200&hellip;+1300 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>5</td><td>термопара ТХА (K)</td><td>&ndash;200&hellip;+1360 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>17</td><td>термопара ТПП (S)</td><td>&ndash;50&hellip;+1750 &deg;C</td><td>0,1 &deg;С</td></tr><tr><td>18</td><td>термопара ТПП (R)</td><td>&ndash;50&hellip;+1750 &deg;C</td><td>0,1 &deg;С</td></tr><tr><td>16</td><td>термопара ТПР (В)</td><td>+200&hellip;+1800 &deg;C</td><td>0,1 &deg;С</td></tr><tr><td>21</td><td>термопара ТВР (А-1)</td><td>0&hellip;+2500 &deg;С</td><td>0,1 &deg;С</td></tr><tr><td>22</td><td>термопара ТВР (А-2)</td><td>0&hellip;+1800 &deg;C</td><td>0,1 &deg;С</td></tr><tr><td>23</td><td>термопара ТВР (А-3)</td><td>0&hellip;+1800 &deg;C</td><td>0,1 &deg;С</td></tr><tr><td>24</td><td>термопара ТМК (Т)</td><td>&ndash;200&hellip;+400 &deg;C</td><td>0,1 &deg;С</td></tr><tr><td>12</td><td>ток 0&hellip;5 мА</td><td>0&hellip;100 %</td><td>0,1 %</td></tr><tr><td>11</td><td>ток 0&hellip;20 мA</td><td>0&hellip;100 %</td><td>0,1 %</td></tr><tr><td>10</td><td>ток 4&hellip;20 мА</td><td>0&hellip;100 %</td><td>0,1 %</td></tr><tr><td>6</td><td>напряжение &ndash;50&hellip;+50 мВ</td><td>0&hellip;100 %</td><td>0,1 %</td></tr><tr><td>13</td><td>напряжение 0&hellip;1 В</td><td>0&hellip;100 %</td><td>0,1 %</td></tr><tr><td colspan=""4"">* При измерении температуры выше 999,9 &deg;С и ниже минус 199,9 &deg;С разрешающая способность прибора 1 &deg;С</td></tr></tbody>
</table>')
INSERT INTO MenuDetails values('Технические характеристики',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://owen.ua/uploads/22/funkcionalnaja-shema-pribora-oven-2-trm-0.jpg" alt="" width="900" height="370" /></p>')
INSERT INTO MenuDetails values('Функциональная схема',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://owen.ua/thumbs/86/n-rus___debccd6e-600x0-d.png" alt="" /></p><p style="text-align: center;"><em>Прибор настенного крепления Н</em></p><p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://owen.ua/thumbs/86/sch1-rus___2b93497f-600x0-d.png" alt="" /></p><p style="text-align: center;"><em>Прибор щитового крепления Щ1</em></p><p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://owen.ua/thumbs/86/sch11_rus___4f01de08-600x0-d.jpg" alt="" /></p><p style="text-align: center;"><em>Прибор щитового крепления Щ11</em></p><p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://owen.ua/thumbs/86/sch2-rus___7eafca42-600x0-d.png" alt="" /></p><p style="text-align: center;"><em>Прибор щитового крепления Щ2</em></p><p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://owen.ua/thumbs/86/d-gabarity-all___26484985-600x0-d.jpg" alt="" /></p><p style="text-align: center;"><em>Прибор с креплением на DIN-рейку</em></p>')

INSERT INTO MenuDetails values('Габаритные и установочные размеры',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://owen.ua/uploads/79/2trm0-obozn.svg" alt="" /></p>')
INSERT INTO MenuDetails values('Обозначение при заказе',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://owen.ua/uploads/60/2trm0-podkl.jpg" alt=""  /></p>')
INSERT INTO MenuDetails values('Схемы подключения',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))

INSERT INTO InfoDetails values('empty','empty URL','<ol>
<li>Прибор 2ТРМ0-Х</li><li>Комплект крепежных элементов</li><li>Резистор 49.9 Ом - 2 шт.</li><li>Руководство по эксплуатации</li> <li>Паспорт и гарантийный талон</li></ol>')
INSERT INTO MenuDetails values('Комплектность',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','<table >
<tbody><tr><td>Документ</td><td>UA</td><td>RU</td></tr><tr>
<td>Руководство по эксплуатации 2ТРМ0</td><td>&nbsp;Скачать</td><td>Скачать</td></tr><tr>
<td>Декларация о соответствии ОВЕН 2ТРМх, ТРМ1, ТРМ1х, ТРМ2хх, ТРМ1хх, УКТ38, ТРМ148, ТРМ151, ТРМ251, МПР51</td><td>Скачать</td><td>&nbsp;</td></tr><tr>
<td>Сертификат соответствия утвержденному типу ОВЕН ТРМ</td><td>Скачать</td><td>&nbsp;</td></tr></tbody>
</table>')
INSERT INTO MenuDetails values('Документация',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','НЕ ЮЗАТЬ  ЭТУ СТРОКУ')
INSERT INTO MenuDetails values('Цены',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))

-------------------------------------- ИТП --------------------------------------
INSERT INTO Details values('Линейка измерителей технологических параметров ОВЕН ИТП предназначена для контроля и отображения на цифровом светодиодном индикаторе унифицированных сигналов тока и напряжения, а также сигналов термосопротивлений и термопар. Приборы поддерживают работу со стандартными датчиками температуры без применения нормирующих преобразователей. Измерители ИТП-14 и ИТП-16 оснащены функцией сигнализации и выполнены в компактных, удобных для монтажа корпусах.')
INSERT INTO Product values(1,1,(SELECT MAX(DetailsId) FROM Details),'ИТП','ИТП. Измеритель технологических параметров','https://owen.ua/thumbs/86/itp_main-img___338ba3bf-450x450-d.jpg')
INSERT INTO PriceDetails values((SELECT MAX(Id) FROM Product ),'11.КР',960.00)
INSERT INTO PriceDetails values((SELECT MAX(Id) FROM Product ),'11.ЗЛ',1068.00)
INSERT INTO PriceDetails values((SELECT MAX(Id) FROM Product ),'14.КР.Щ9.К',1182.00 )
INSERT INTO PriceDetails values((SELECT MAX(Id) FROM Product ),'11.ЗЛ.Н3',1182.00)
INSERT INTO PriceDetails values((SELECT MAX(Id) FROM Product ),'16.КР.Щ9.К',1182.00)
INSERT INTO PriceDetails values((SELECT MAX(Id) FROM Product ),'11.КР.Н3',1182.00)
INSERT INTO PriceDetails values((SELECT MAX(Id) FROM Product ),'14.ЗЛ.Щ9.К',1326.00)
INSERT INTO PriceDetails values((SELECT MAX(Id) FROM Product ),'16.ЗЛ.Щ9.К',1326.00)
INSERT INTO InfoDetails values('empty','empty URL','<p>Измерители технологических параметров ОВЕН ИТП предназначены для контроля и отображения на цифровом светодиодном индикаторе значений таких параметров технологических процессов, как унифицированные сигналы постоянного тока и напряжения, а также сигналов термосопротивлений и термопар. Приборы поддерживают работу со стандартными датчиками температуры без применения нормирующих преобразователей. В измерителях ИТП-14 и ИТП-16 реализована функция сигнализации о достижении контролируемым параметром заданного пользователем значения.</p><p>&nbsp;</p><h3><strong>Функциональные возможности приборов ОВЕН ИТП</strong></h3>
<ul><li>&nbsp;Контроль температуры или другой физической величины (давления, влажности, уровня и т. п.)</li><li>&nbsp;Масштабирование измеренного сигнала в нужные единицы измерения (для ИТП-11, ИТП-14)</li><li>&nbsp;Возможность вычисления квадратного корня (для ИТП-11, ИТП-14)</li><li>&nbsp;Индикация аварии при обрыве входного сигнала или выхода за указанные границы</li><li>&nbsp;Возможность мигания индикатора при входе измеряемой величины в критическую зону*</li><li>&nbsp;Выходное устройство для сигнализации или управления 200мА\42В (для ИТП-14, ИТП-16)</li><li>&nbsp;Питание:
<ul><li>&nbsp;от внешнего источника постоянного напряжения 24В (для ИТП-14, ИТП-16)</li><li>&nbsp;от токовой петли, падение напряжения 4В (для ИТП-11 в щитовом корпусе)**</li></ul>
</li><li>&nbsp;Крепление:
<ul><li>&nbsp;на дверцу щита в отверстие 22мм</li><li>&nbsp;на стену (для ИТП-11)</li><li>&nbsp;DIN рейку (для ИТП-11)</li><li>&nbsp;на трубу (для ИТП-11)</li></ul>
</li><li>&nbsp;Самозажимные клеммные соединители (для ИТП-14, ИТП-16)</li><li>&nbsp;Красная или зеленая индикация (оговаривается при заказе)</li><li>&nbsp;Эксплуатация при температуре окружающий среды: от -40 до +60 &deg;С</li></ul>
<p>&nbsp;</p><p><strong>Внимание!</strong>&nbsp;Для приборов ИТП-11.х.Н3 (настенное исполнение):</p><p><em>* функция мигания ЦИ отсутствует</em></p><p><em>**падение напряжения при питании от измеряемого сигнала составляет 10В.</em></p>')
INSERT INTO MenuDetails values('Описание',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','<table class="InfoDetailsTableCells">
<tbody><tr><td colspan="1" rowspan="2">
<p><strong>Наименование</strong></p></td><td>змеритель 4..20 мА с питанием от сигнала</td><td>змеритель унифицированных сигналов с внешним питанием</td><td>змеритель термопар и термосопротивлений</td></tr><tr><td>ОВЕН ИТП-11</strong></td><td>ОВЕН ИТП-14</strong></td><td>ОВЕН ИТП-16</strong></td></tr><tr><td colspan="4">
<h3><strong>Питание</strong></h3></td></tr><tr><td><p>Напряжение питания</p></td><td><p>токовая петля датчика 4..20 мА, не более 4 В*</p></td><td colspan="2">
<div><p>10&hellip;30 В постоянного тока (номинал. напряжение 24 В),<br />потребляемая мощность не более 1 Вт</p></div>
</td></tr><tr><td colspan="4">
<h3><strong>Характеристики входных сигналов</strong></h3></td></tr><tr><td><p>Количество каналов измерения</p></td><td><p>1</p></td><td><p>1</p></td><td><p>1</p></td></tr><tr><td><p>Тип входного сигнала</p></td><td><p>4..20 мА</p></td><td><p>Ток 0...5 мА, 0(4)&hellip;20 мА<br />Напряжение 0(2)&hellip;10 В</p></td><td><p>см. таблицу "Характеристики измерительных датчиков"</p></td></tr><tr><td><p>Входное сопротивление при измерении напряжения, не более</p></td><td><p>&nbsp;-</p></td><td colspan="2"><p>250 кОм</p></td></tr><tr><td><p>Время опроса входа, не более</p></td><td><p>1 с</p></td><td><p>0,3 с</p></td><td><p>1 с</p></td></tr><tr><td colspan="4"><h3><strong>Метрологические характеристики</strong></h3></td></tr><tr><td><p>Пределы основной приведенной погрешности, %</p></td><td><p>&plusmn;(0,2+N), где N &ndash; единица последнего разряда, выраженная в процентах от диапазона преобразования</p></td><td><p>&plusmn;0,25</p></td><td><p>при работе с ТС, унифицированными сигналами напряжения: &plusmn; 0,25;</p><p>при работе с ТП: &plusmn; 0,5</p></td></tr><tr><td colspan="4"><h3><strong>Характеристики выходных сигналов</strong></h3></td></tr><tr><td><p>Количество выходных устройств</p></td><td><p>-</p></td><td><p>1</p></td><td><p>1</p></td></tr><tr><td><p>Типы выходных устройств</p></td><td><p>-</p></td><td colspan="2"><div><p>Транзисторный ключ n-p-n типа:<br />&ndash; максимальный постоянный ток нагрузки 200 мА<br />&ndash; максимальное напряжение постоянного тока 42В</p></div></td></tr><tr><td colspan="4"><h3><strong>Конструктивные исполнения</strong></h3></td></tr><tr><td><p>Габаритные размеры</p></td><td><div><p>- щитовой Щ9 : 26&times;48&times;65 мм,<br />- настенный Н3 : 70&times;50&times;28&nbsp;мм</p></div></td><td colspan="2"><p>щитовой Щ9 : 26&times;48&times;65 мм</p></td></tr><tr><td colspan="4"><h3><strong>Условия эксплуатации</strong></h3></td></tr><tr><td><p>Диапазон рабочих температур</p></td><td><p>от -40 до +80 &deg;С</p></td><td colspan="2"><p>от -40 до +60 &deg;С</p></td></tr><tr><td><p>Относительная влажность воздуха</p></td><td colspan="3"><p>не более 80% , при +35 &deg;С и более низких температурах без конденсации влаги</p></td></tr><tr><td><p>Атмосферное давление</p></td><td colspan="3"><p>от 84 до 106,7 кПа</p></td></tr><tr><td><p>Устойчивость к механическим воздействиям</p></td><td colspan="3"><p>приборсоответствует группе исполнения N2 по ГОСТ 12997</p></td></tr><tr><td><p>Устойчивость к электромагнитным воздействиям</p></td><td colspan="3"><p>&nbsp;прибор соответствует оборудованию класса А по ДСТУ IEC 61326-1</p></td></tr></tbody></table><p><em>* Для приборов в корпусе Щ9 падение напряжения составляет 4 В, для приборов в корпусе Н3 &ndash; 10 В.</em></p><p>&nbsp;</p><h3><strong>Характеристики надежности</strong></h3><table><tbody><tr><td><p>Степень защиты корпуса:</p></td><td><p>&nbsp;</p></td></tr><tr><td><p>&ndash; настенный Н3</p></td><td><p>IP65</p></td></tr><tr><td><p>&ndash; щитовой Щ9 (со стороны лицевой панели)</p></td><td><p>IP65</p></td></tr><tr><td><p>&ndash; щитовой Щ9 (со стороны клемм)</p></td><td><p>IP20</p></td></tr><tr><td><p>Средняя наработка на отказ</p></td><td><p>100000 ч</p></td></tr><tr><td><p>Средний срок службы</p></td><td><p>12 лет</p></td></tr></tbody></table><h3><strong>Характеристики измерительных датчиков</strong></h3><table class="InfoDetailsTableCells"><tbody><tr><td><p><strong>Обозначение на индикаторе</strong></p></td><td><p><strong>Условное обозначение датчика</strong></p></td><td><p><strong>Диапазон измерений,&nbsp;&deg;С</strong></p></td><td><p><strong>Обозначение на индикаторе</strong></p></td><td><p><strong>Условное обозначение датчика</strong></p></td><td><p><strong>Диапазон измерений,&nbsp;&deg;С</strong></p></td></tr><tr><td colspan="3"><p><strong>Термопреобразователи сопротивления по&nbsp;ДСТУ&nbsp;6651</strong></p></td><td colspan="3"><p><strong>Термоэлектрические преобразователи по ДСТУ EN 60584-1</strong></p></td></tr><tr><td><p><strong>c50</strong></p></td><td><p>Cu50</p><p>(a<sup>1)</sup>= 0,00426 &deg;С<sup>-1</sup>)</p></td><td><p>-50&hellip;+200</p></td><td><p><strong>tP.L</strong></p></td><td><p>TХК (L)</p></td><td><p>-200&hellip;+800</p></td></tr><tr><td><p><strong>c100</strong></p></td><td><p>Cu100</p><p>(a = 0,00426 &deg;С<sup>-1</sup>)</p></td><td><p>-50&hellip;+200</p></td><td><p><strong>tP.KA</strong></p></td><td><p>TХА (К)</p></td><td><p>-200&hellip;+1300</p></td></tr><tr><td><p><strong>c 500</strong></p></td><td><p>Cu500</p><p>(a = 0,00426 &deg;С&nbsp;<sup>-1</sup>)</p></td><td><p>-50 &hellip;+200</p></td><td><p><strong>tP.J</strong></p></td><td><p>TЖК (J)</p></td><td><p>-200&hellip;+1200</p></td></tr><tr><td><p><strong>c1E3</strong></p></td><td><p>Cu1000</p><p>(a = 0,00426&deg;С<sup>-1</sup>)</p></td><td><p>-50&hellip;+200</p></td><td><p><strong>tP.n</strong></p></td><td><p>TНН (N)</p></td><td><p>-200&hellip;+1300</p></td></tr><tr><td colspan="3"><p><strong>Термопреобразователи сопротивления по&nbsp;ДСТУ 2858</strong></p></td><td><p><strong>tP.t</strong></p></td><td><p>TМК (Т)</p></td><td><p>-250&hellip;+40</p></td></tr><tr><td><p><strong>c.50</strong></p></td><td><p>50М</p><p>(a = 0,00428 &deg;С&nbsp;<sup>-1</sup>)</p></td><td><p>-180&hellip;+200</p></td><td><p><strong>tP.S</strong></p></td><td><p>TПП 10 (S)</p></td><td><p>-50&hellip;+1750</p></td></tr><tr><td><p><strong>P50</strong></p></td><td><p>Pt50</p><p>(a = 0,00385 &deg;С<sup>-1</sup>)</p></td><td><p>-200&hellip;+850</p></td><td><p><strong>tP.r</strong></p></td><td><p>TПП 13 (R)</p></td><td><p>-50&hellip;+1750</p></td></tr><tr><td><p><strong>P.50</strong></p></td><td><p>50П</p><p>(a = 0,00391 &deg;С<sup>-1</sup>)</p></td><td><p>-200&hellip;+850</p></td><td><p><strong>tP.b</strong></p></td><td><p>TПР (В)</p></td><td><p>+200&hellip;+1800</p></td></tr><tr><td><p><strong>c.100</strong></p></td><td><p>100М</p><p>(a = 0,00428 &deg;С<sup>-1</sup>)</p></td><td><p>-180&hellip;+200</p></td><td><p><strong>tP.A1</strong></p></td><td><p>TВР (А)</p></td><td><p>0&hellip;+2500</p></td></tr><tr><td><p><strong>P100</strong></p></td><td><p>Pt100</p><p>(a = 0,00385 &deg;С&nbsp;<sup>-1</sup>)</p></td><td><p>-200&hellip;+850</p></td><td colspan="3"><p><strong>Термоэлектрические преобразователи по&nbsp;ДСТУ 2837<sup>2)</sup></strong></p></td></tr><tr><td><p><strong>P.100</strong></p></td><td><p>100П</p><p>(a = 0,00391 &deg;С&nbsp;<sup>-1</sup>)</p></td><td><p>-200&hellip;+850</p></td><td><p><strong>tP.A2</strong></p></td><td><p>TВР (А-2)</p></td><td><p>0&hellip;+1800</p></td></tr><tr><td><p><strong>N100</strong></p></td><td><p>100Н</p><p>(a = 0,00617 &deg;С&nbsp;<sup>-1</sup>)</p></td><td><p>-60&hellip;+180</p></td><td><p><strong>tP.A3</strong></p></td><td><p>TВР (А-3)</p></td><td><p>0&hellip;+1800</p></td></tr><tr><td><p><strong>P500</strong></p></td><td><p>Pt500</p><p>(a = 0,00385 &deg;С&nbsp;<sup>-1</sup>)</p></td><td><p>-200&hellip;+850</p></td><td colspan="3" rowspan="2"><p><strong>Термоэлектрические преобразователи по DIN 43710</strong></p></td></tr><tr><td><p><strong>P.500</strong></p></td><td><p>500П</p><p>(a = 0,00391 &deg;С&nbsp;<sup>-1</sup>)</p></td><td><p>-200&hellip;+850</p></td></tr><tr><td><p><strong>c.500</strong></p></td><td><p>500М</p><p>(a = 0,00428 &deg;С&nbsp;<sup>-1</sup>)</p></td><td><p>-180&hellip;+200</p></td><td><p><strong>tP.tL</strong></p></td><td><p>Type L</p></td><td><p>-200&hellip;+900</p></td></tr><tr><td><p><strong>n500</strong></p></td><td><p>500Н</p><p>(a = 0,00617 &deg;С&nbsp;<sup>-1</sup>)</p></td><td><p>-60&hellip;+180</p></td><td colspan="3" rowspan="13"><p><strong>Примечания:</strong></p><p><em><sup>1)&nbsp;&nbsp;&nbsp;</sup>&alpha;-температурный коэффициент термопреобразователя сопротивления &ndash; отношение разницы сопротивлений датчика, измеренных при температуре 100 и 0 &deg;С, к его сопротивлению, измеренному при&nbsp;0&nbsp;&deg;С&nbsp;(R<sub>0</sub>), деленное на 100 &deg;С и&nbsp;округленное до пятого знака после&nbsp;запятой;</em></p><p>&nbsp;</p><p><em><sup>2)&nbsp;&nbsp;&nbsp;</sup>ДСТУ 2837 отменен в Украине и&nbsp;используется как информационный источник</em></p></td></tr><tr><td><p><strong>c.1E3</strong></p></td><td><p>1000М</p><p>(a = 0,00428&deg;С<sup>-1</sup>)</p></td><td><p>-180&hellip;+200</p></td></tr><tr><td><p><strong>P1E3</strong></p></td><td><p>Pt1000</p><p>(a = 0,00385&deg;С<sup>-1</sup>)</p></td><td><p>-200&hellip;+850</p></td></tr><tr><td><p><strong>P.1E3</strong></p></td><td><p>1000П</p><p>(a = 0,00391&deg;С<sup>-1</sup>)</p></td><td><p>-200&hellip;+850</p></td></tr><tr><td><p><strong>n1E3</strong></p></td><td><p>1000Н</p><p>(a = 0,00617&deg;С<sup>-1</sup>)</p></td><td><p>-60&hellip;+180</p></td></tr><tr><td colspan="3"><p><strong>Пирометры с градуировками по&nbsp;ГОСТ&nbsp;10627</strong></p></td></tr><tr><td><p><strong>PK15</strong></p></td><td><p>РК-15</p></td><td><p>+400&hellip;+1500</p></td></tr><tr><td><p><strong>PK20</strong></p></td><td><p>РК-20</p></td><td><p>+600&hellip;+2000</p></td></tr><tr><td><p><strong>PC20</strong></p></td><td><p>РС-20</p></td><td><p>+900&hellip;+2000</p></td></tr><tr><td colspan="3">
<p><strong>Сигнал напряжения по ГОСТ 26.011-80</strong></p></td></tr><tr><td><p><strong>0-1</strong></p></td><td><p>0&hellip;1 В</p></td><td><p>-999&hellip;9999</p></td></tr><tr><td colspan="3"><p><strong>Сигнал напряжения</strong></p></td></tr><tr><td><p><strong>50.50</strong></p></td><td><p>-50&hellip;+50 мВ</p></td><td><p>-999&hellip;9999</p></td></tr></tbody></table>')
INSERT INTO MenuDetails values('Технические характеристики',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','<table class="InfoDetailsTableCells" cellspacing="1" cellpadding="1"><tbody><tr><td><img style="display: block; margin-left: auto; margin-right: auto;" src="https://owen.ua/thumbs/85/itp-11-func___a0fb0e00-200x0-d.jpg" alt="" width="200" height="112" /></td><td style="text-align: center;"><img src="https://owen.ua/thumbs/85/itp-14-func___b9120eb6-200x0-d.jpg" alt="" width="200" height="149" /></td><td style="text-align: center;"><img src="https://owen.ua/thumbs/85/itp-16-func___23dfffdd-200x0-d.jpg" alt="" width="200" height="169" /></td></tr><tr><td><em>Функциональная схема ОВЕН ИТП-11</em></td><td><em>Функциональная схема ОВЕН ИТП-14</em></td><td><em>Функциональная схема ОВЕН ИТП-16</em></td></tr></tbody></table>')
INSERT INTO MenuDetails values('Функциональная схема',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','<table class="InfoDetailsTableCells" cellspacing="1" cellpadding="1"><tbody><tr><td><img src="https://owen.ua/thumbs/26/itp11-konstr___564feff6-350x0-d.jpg" alt="Габаритные размеры прибора щитового исполнения Щ9" /></td><td><img src="https://owen.ua/thumbs/72/itp11-n3-konstr___d25aef81-350x0-d.png" alt="Габаритные размеры прибора настенного исполнения Щ9" /></td></tr><tr><td style="text-align: center;"><em >Габаритные размеры прибора щитового исполнения Щ9</em></td><td style="text-align: center;"><em >Габаритные размеры прибора настенного исполнения Н3</em></td></tr></tbody></table><p>&nbsp;</p><table class="InfoDetailsTableCells" cellspacing="1" cellpadding="1"><tbody><tr><td><img src="https://owen.ua/thumbs/85/montazh1___3f0b822b-181x0-d.jpg" alt="Монтаж прибора в щит" /></td><td><img src="https://owen.ua/thumbs/85/montazh2___95ff186a-282x0-d.jpg" alt="Монтаж прибора в щит" /></td></tr><tr><td colspan="2" style="text-align: center;"><em>Монтаж прибора в щит</em></td></tr></tbody></table><p>&nbsp;</p><table class="InfoDetailsTableCells" cellspacing="1" cellpadding="1"><tbody><tr><td><img src="https://owen.ua/thumbs/85/ustanovka1___8b759e7c-353x0-d.jpg" alt="Установка приборов настенного исполнения" /></td><td><img src="https://owen.ua/thumbs/85/ustanovka2___4b4bcc06-350x0-d.jpg" alt="Установка приборов настенного исполнения" /></td></tr><tr><td colspan="2" style="text-align: center;"><em>Установка приборов настенного исполнения</em></td></tr></tbody></table>')
INSERT INTO MenuDetails values('Габаритные и установочные размеры',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://owen.ua/uploads/86/1/itp_11_ru.svg" alt="" /></p><p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://owen.ua/uploads/86/1/itp_14_16_ru.svg" alt="" /></p>')
INSERT INTO MenuDetails values('Обозначение при заказе',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','<h3><strong>Схемы подключения ИТП-11</strong></h3><table class="InfoDetailsTableCells" cellspacing="1" cellpadding="1"><tbody><tr><td><p><img src="https://owen.ua/thumbs/71/itp11_sh1_podkl_ukr___7a33c851-200x0-d.png" alt="Подключение ИТП-11 к пассивному источнику 4...20мА" /></p></td><td><img src="https://owen.ua/thumbs/71/itp11_sh2_podkl_ukr___75aa0a27-200x0-d.png" alt="Подключение ИТП-11 к активному источнику 4...20мА" /></td><td><img src="https://owen.ua/thumbs/71/itp11_sh3_podkl_ukr___dfad0b6e-143x0-d.png" alt="Подключение нескольких ИТП-11 к пассивному источнику 4...20мА" /></td></tr><tr><td><em>Подключение ИТП-11 к пассивному источнику 4...20мА</em></td><td><em>Подключение ИТП-11 к активному источнику 4...20мА</em></td><td><em>Подключение нескольких ИТП-11 к пассивному источнику 4...20мА</em></td></tr></tbody></table><p>&nbsp;</p><h3><strong>Схемы подключения ИТП-11.Н3</strong></h3><table class="InfoDetailsTableCells" cellspacing="1" cellpadding="1"><tbody><tr><td><p><img src="https://owen.ua/thumbs/72/itp11-n3-podkl-sprava___6ce89894-200x0-d.png" alt="Подключение ИТП11.Н3 справа" /></p></td><td><img src="https://owen.ua/thumbs/72/itp11-n3-podkl-sleva___2f048c4f-200x0-d.png" alt="Подключение ИТП11.Н3 слева" /></td><td><img src="https://owen.ua/thumbs/72/itp11-n3-podkl-skvoznoe___82fd916b-200x0-d.png" alt="Подключение нескольких ИТП-11 к пассивному источнику 4...20мА" /></td></tr><tr><td><em>Подключение ИТП11.Н3 справа</em></td><td><em>Подключение ИТП11.Н3 слева</em></td><td><em>Сквозное подключение ИТП11.Н3 (на выбор - к клеммам 1, 4 или 2, 3)</em></td></tr></tbody></table><p>&nbsp;</p><h3><strong>Схемы подключения ИТП-14</strong></h3><table class="InfoDetailsTableCells" cellspacing="1" cellpadding="1"><tbody><tr><td><p><img src="https://owen.ua/thumbs/85/itp-14_podkl-bp___ae86dbbc-150x0-d.jpg" alt="Подключение питания" /></p></td><td><img src="https://owen.ua/thumbs/85/itp-14_podkl-tok___54d6c8d0-150x0-d.jpg" alt="Подключение унифицированных сигналов тока " /></td><td><img src="https://owen.ua/thumbs/85/itp-14_podkl-napr___120e4ca6-150x0-d.jpg" alt="Подключение унифицированных сигналов напряжения" /></td><td><img src="https://owen.ua/thumbs/85/itp-14_podkl-diskret-vyhod___af630223-150x0-d.jpg" alt="Подключение нагрузки к дискретному выходу" /></td></tr><tr><td><em>Подключение питания</em></td><td><em>Подключение унифицированных сигналов тока 0&hellip;20 мА, 0&hellip;5 мА, 4&hellip;20 мА</em></td><td><em>Подключение унифицированных сигналов напряжения 0&hellip;10 В, 2&hellip;10 В</em></td><td>Подключение нагрузки к дискретному выходу</td></tr></tbody></table><p>&nbsp;</p><h3><strong>Схемы подключения ИТП-16</strong></h3><table class="InfoDetailsTableCells" cellspacing="1" cellpadding="1"><tbody><tr><td><p><img src="https://owen.ua/thumbs/85/itp-16_podkl-bp___13acd7cd-150x0-d.jpg" alt="Подключение питания" /></p></td><td><img src="https://owen.ua/thumbs/85/itp-16_podkl-preobr___5687c7a9-300x0-d.jpg" alt="Подключение первичных преобразователей" /></td><td><img src="https://owen.ua/thumbs/85/itp-16_podkl-diskret-vyhod___6cff65c6-150x0-d.jpg" alt="Подключение нагрузки к дискретному выходу" /></td></tr><tr><td><em>Подключение питания</em></td><td><em>Подключение унифицированных сигналов тока 0&hellip;20 мА, 0&hellip;5 мА, 4&hellip;20 мА</em></td><td><em>Подключение унифицированных сигналов напряжения 0&hellip;10 В, 2&hellip;10 В</em></td></tr></tbody></table>')
INSERT INTO MenuDetails values('Схемы подключения',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','<ol><li>Прибор ОВЕН ИТП</li><li>Комплект крепежных элементов</li><li>Паспорт и гарантийный талон</li><li>Руководство по эксплуатации</li><li>Комплект наконечников</li><li>Методика поверки (по требованию заказчика)</li></ol><p><em>Примечание - Изготовитель оставляет за собой право внесения дополнений в комплектность изделия.</em></p>')
INSERT INTO MenuDetails values('Комплектность',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','<table class="InfoDetailsTableCells"><tbody><tr><th>Документ</th><th>&nbsp;</th><th>&nbsp;</th></tr><tr><td>Руководство по эксплуатации ИТП-11</td><td>&nbsp;</td><td><a href="https://owen.ua/uploads/89/re_oven_itp-11_m04__ukr_618_a4.pdf" target="_blank" rel="noopener" data-pjax="0">RU</a></td></tr><tr><td>Руководство по эксплуатации ИТП-14</td><td>&nbsp;</td><td><a href="https://owen.ua/uploads/85/re_oven_itp-14_ukr_597.pdf" target="_blank" rel="noopener" data-pjax="0">RU</a></td></tr><tr><td>Руководство по эксплуатации ИТП-16</td><td>&nbsp;</td><td><a href="https://owen.ua/uploads/85/re_oven_itp-16_ukr_598.pdf" target="_blank" rel="noopener" data-pjax="0">RU</a></td></tr><tr><td>Краткое руководство ИТП-11.Н3</td><td>&nbsp;</td><td><a href="https://owen.ua/uploads/76/kr_oven_itp-11.n3_ukr_012.pdf" target="_blank" rel="noopener" data-pjax="0">RU</a></td></tr><tr><td>Декларация о соответствии ОВЕН ИТП-11</td><td><a href="https://owen.ua/uploads/77/decl-itp11.jpg" target="_blank" rel="noopener" data-pjax="0">UA</a></td><td>&nbsp;</td></tr><tr><td>Декларация о соответствии ОВЕН ИТП-14, ОВЕН ИТП-16</td><td><a href="https://owen.ua/uploads/85/decl-itp14-itp16.jpg" target="_blank" rel="noopener" data-pjax="0">UA</a></td><td>&nbsp;</td></tr><tr><td>Сертификат утверждения типа СИТ ОВЕН ИТП10, ИТП-11</td><td><a href="https://owen.ua/uploads/62/sert_itp10-11.jpg" target="_blank" rel="noopener" data-pjax="0">UA</a></td><td>&nbsp;</td></tr></tbody></table>')
INSERT INTO MenuDetails values('Документация',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','Раздел в  разработке')
INSERT INTO MenuDetails values('Проектировщику в помощь',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))
INSERT INTO InfoDetails values('empty','empty URL','НЕ ЮЗАТЬ  ЭТУ СТРОКУ')
INSERT INTO MenuDetails values('Цены',(SELECT MAX(InfoDetailsId) FROM InfoDetails),(SELECT MAX(DetailsId) FROM Details))


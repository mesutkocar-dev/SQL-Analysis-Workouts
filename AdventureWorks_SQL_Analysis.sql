-- AdventureWorks2022 veri tabanını kullanıma alıyoruz
USE AdventureWorks2022;
GO

-- 1. CONCAT: Ad, Soyad ve sabit bir metni birleştirerek çalışan bilgisi oluşturma
SELECT CONCAT(FirstName, ' ', LastName, ' - Çalışan') AS Bilgi
FROM Person.Person;
GO

-- 2. YEAR & ORDER BY: Çalışanların unvanlarını ve işe giriş yıllarını, en yeni girişten eskiye sıralama
SELECT JobTitle, YEAR(HireDate) AS Ise_Giris_Yili
FROM HumanResources.Employee 
ORDER BY HireDate DESC;
GO

-- 3. DATEDIFF: Çalışanların bugüne kadar olan deneyim yıllarını hesaplama
-- NOT: WHERE kısmındaki hata düzeltildi, sadece deneyim yılı hesaplandı.
SELECT HireDate,
       DATEDIFF(YEAR, HireDate, GETDATE()) AS Deneyim_Yili
FROM HumanResources.Employee;
GO

-- 4. ISNULL & CAST: Null olan bitiş tarihlerini 'Devam Ediyor' olarak işaretleme
-- CAST kullanımı, tarih ve metin veri tiplerini uyumlu hale getirmek için önemlidir.
SELECT ISNULL(CAST(EndDate AS VARCHAR(20)), 'Devam Ediyor') AS Gorev_Durumu
FROM HumanResources.EmployeeDepartmentHistory;
GO

-- 5. SUBQUERY (İç İçe Sorgu): Ortalama saatlik ücretin (Rate) üzerinde alanları listeleme
SELECT Rate 
FROM HumanResources.EmployeePayHistory
WHERE Rate > (SELECT AVG(Rate) FROM HumanResources.EmployeePayHistory);
GO

-- 6. GROUP BY & COUNT: Yıllara göre işe alınan personel dağılımını analiz etme
SELECT YEAR(HireDate) AS Yil, COUNT(*) AS Calisan_Sayisi 
FROM HumanResources.Employee 
GROUP BY YEAR(HireDate) 
ORDER BY Calisan_Sayisi DESC;
GO 

-- 7. JOIN & LIKE: Personel ve Çalışan tablolarını birleştirerek unvanında 'Assistant' geçenleri bulma
SELECT CONCAT(P.FirstName, ' ', P.LastName) AS Ad_Soyad,
       E.JobTitle
FROM Person.Person P
JOIN HumanResources.Employee E ON P.BusinessEntityID = E.BusinessEntityID
WHERE E.JobTitle LIKE '%Assistant%';
GO

-- 8. CASE WHEN: Saatlik ücretlere göre çalışanları kategorize etme (Koşullu Mantık)
SELECT Rate,
       CASE 
           WHEN Rate < 20 THEN 'DÜŞÜK'
           WHEN Rate BETWEEN 20 AND 50 THEN 'ORTA' -- Opsiyonel: Analizi derinleştirmek için eklendi
           ELSE 'YÜKSEK' 
       END AS Ucret_Seviyesi 
FROM HumanResources.EmployeePayHistory
ORDER BY Rate DESC;
GO

























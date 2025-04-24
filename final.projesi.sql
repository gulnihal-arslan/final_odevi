-- 1. categories Tablosu: Kategoriler
CREATE TABLE categories (
    id SMALLINT PRIMARY KEY,            -- id, birincil anahtar
    kategori_adi VARCHAR(100) NOT NULL UNIQUE   -- kategori adi: Kategori adı noş olmaması için not null, aynı isimde bir kategori olmaması için unique kullandım 
);

-- 2. Members Tablosu: Üyeler
CREATE TABLE Members (
    id SERIAL PRIMARY KEY,                      -- id , birincil anahtar 
    kullanici_adi VARCHAR(50) UNIQUE NOT NULL,   
    eposta VARCHAR(100) UNIQUE NOT NULL,        
    sifre VARCHAR(255) NOT NULL,                 
    kayit_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Kayıt tarihi, varsayılan olarak şimdiki zamanı almalı (CURRENT_TIMESTAMP).
    ad VARCHAR(50),                              
    soyad VARCHAR(50)                            
);

-- 3. Courses Tablosu: Eğitimler
CREATE TABLE Courses (
    id SERIAL PRIMARY KEY,                   
    adi VARCHAR(200) NOT NULL,                
    aciklama TEXT,                            
    baslangic DATE,                           
    bitis DATE,                               
    egitmen_bilgisi VARCHAR(100),          
    category_id SMALLINT REFERENCES categories(id) -- category_id  yabancı anahtar, `categories` tablosundaki `id` sütununa referans 
);

-- 4. Enrollments Tablosu: Katılım Bilgileri
CREATE TABLE enrollments (
    id SERIAL PRIMARY KEY,                  -- id  birincil anahtar 
    kullanici INTEGER REFERENCES Members(id) ON DELETE CASCADE,  -- kullanici: Katılımı yapan kullanıcı, `Members(id)` sütununa yabancı anahtar referans , Kullanıcı silinirse, katılım da silinir (CASCADE).
    egitimler INTEGER REFERENCES Courses(id) ON DELETE CASCADE, -- egitimler: Katılınan eğitim, `Courses(id)` sütununa yabancı anahtar referansı. Eğitim silinirse, katılım da silinir (CASCADE).
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP  
);

-- 5. Certificates Tablosu: Sertifikalar
CREATE TABLE certificates (
    id SERIAL PRIMARY KEY,                
    sertifika_kodu VARCHAR(100) UNIQUE NOT NULL, 
    verilis_tarihi DATE NOT NULL         
);

-- 6. CertificateAssignments Tablosu: Sertifika Atamaları
CREATE TABLE CertificateAssignments (
    id SERIAL PRIMARY KEY,                      -- id birincil anahtar 
    member_id INTEGER REFERENCES Members(id) ON DELETE CASCADE, -- member_id `Members(id)` sütununa yabancı anahtar referansı. Üye silinirse, sertifika ataması da silinir 
    sertifika_kodu VARCHAR(100) REFERENCES certificates(sertifika_kodu) ON DELETE CASCADE, 
	-- sertifika_kodu: Verilen sertifika, `certificates(sertifika_kodu)` sütununa yabancı anahtar referans .Sertifika silinirse, atama da silinir 
    alim_tarihi DATE                    
);

-- 7. BlogPosts Tablosu: Blog Gönderileri
CREATE TABLE BlogPosts (
    id SERIAL PRIMARY KEY,                  -- id birincil anahtar 
    baslik VARCHAR(255) NOT NULL,            
    icerik TEXT NOT NULL,                   
    yayin_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    yazar_bilgisi INTEGER REFERENCES Members(id) ON DELETE CASCADE  --Yazar silinirse, blog gönderisi de silinir 
);

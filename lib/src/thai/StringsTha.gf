-- a repository of literal Thai strings

resource StringsTha = {

flags coding = utf8 ;

oper

-- if Thai is paired with Pronunciation, return the latter
thpron : Str -> Str -> Str = \t,p -> p ;

aphai_s = "อภัย" ; -- excuse2
baan_s = "บ้าน" ; -- house
biar_s = "เบียร์" ; -- beer
ca_s = "จะ" ; -- Modal
cet_s = "เจ็ด" ; -- seven
chan_s = "ฉัน" ; -- I
chay_s = "ใช่" ; -- yes
cheut_s = "เชื้ต" ; -- shirt2
chuay_s = "ช่วย" ; -- help1
di_s = "ดิ" ; -- I (fem)1
dii_s = "ดี" ; -- hello2
duay_s = "ด้วย" ; -- help2
dvm_s = "ดึม" ; -- drink
eeng_s = "เอง" ; -- self
et_s = "เอ็ด" ; -- one'
haa_s = "ห้า" ; -- five
hay_s = "ให้" ; -- give
hoog_s = "ห้อง" ; -- room
hok_s = "หก" ; -- six
jai_s = "ใจ" ; -- understand2
kaaw_s = "เก้า" ; -- nine
kam_s = "กำ" ; -- Progr1
kew_s = "แก้ว" ; -- glass (drink Classif)
khaw_s = "เขา" ; -- he
khon_s = "คน" ; -- people Classif
khoo_s = "ขอ" ; -- please
khoog_s = "ของ" ; -- Possessive
khoop_s = "ขอบ" ; -- thank
khow_s = "เข้ว" ; -- understand1
khun_s = "คุณ" ; -- you
koon_s = "ก่อน" ; -- bye2
kwaa_s = "กว่า" ; -- comparative
mii_s = "มี" ; -- have
laa_s = "ลา" ; -- bye1
lag2_s = "ลัง" ; -- Progr2
lag_s = "หลัง" ; -- houses Classif
lap_s = "หลับ" ; -- sleep2 
lem_s = "เล่ม" ; -- books Classif
mak_s = "มาก" ; -- very
may_s = "ไม่" ; -- not
m'ay_s = "ไหม" ; -- Question
mvvn_s = "หมื่น" ; -- ten thousand
nag_s = "หนะง" ; -- book1
nai_s = "ไหน" ; -- where2
nam_s = "นำ" ; -- water
nan_s = "นั้น" ; -- that
nii_s = "นี้" ; -- this
nit_s = "นิด" ; -- little1
noon_s = "นอน" ; -- sleep1
noi_s = "หน่อย" ; -- little2
nvg_s = "หนึง" ; -- one
pay_s = "ไป" ; -- go
peet_s = "แปด" ; -- eight
pen_s = "เป็น" ; -- be, can-know
phan_s = "พัน" ; -- thousand
phom_s = "ผม" ; -- I (masc)
puu_s = "ผู้" ; -- woman1
rai_s = "ไร" ; -- how-much2
rak_s = "รัก" ; -- love
raw_s = "เรา" ; -- we
rooy_s = "ร้อย" ; -- hundred
saam_s = "สาม" ; -- three
sawat_s = "สวัส" ; -- hello1
seen_s = "แสน" ; -- hundred thousand
seua_s = "เสื้อ" ; -- shirt1
si_s = "ซิ" ; -- Imperative
sii_s = "สี่" ; -- four
sip_s = "สิบ" ; -- ten
soog_s = "สอง" ; -- two
sut_s = "สุด" ; -- Superlative
svv_s = "สือ" ; -- book2
thii_s = "ที่" ; -- Ord
thoot_s = "โทr'" ; -- sorry2
thao_s = "เท่า" ; -- how-much1
thuuk_s = "ถูก" ; -- passive
tog_s = "ต้อง" ; -- must
tua_s = "ตัว" ; -- refl pronoun
waa_s = "ว่า" ; -- that Conj
way_s = "ไหว" ; -- can-potent
yaa_s = "อย่า" ; -- Neg Imper
yaak_s = "อยาก" ; -- want
yay_s = "ใหญ" ; -- big
yig_s = "หญิง" ; -- woman2
yii_s = "ยี่" ; -- two'
yin_s = "ยิน" ; -- you're-welcome1
yuu_s = "อยู่" ; -- be (in a place)

}

-- (c) 2009 Krasimir Angelov under LGPL

concrete FoodsMkd of Foods = {

flags coding = utf8 ;

lincat
    Comment = Str;
    Quality = {s : Agr => Str};
    Item = {s : Str; a : Agr};
    Kind = {s : Number => Str; g : Gender};

lin
    Pred item qual = 
       item.s ++
       case item.a of {
         ASg _ => "е";
         APl => "се"
       } ++
       qual.s ! item.a;
    This kind = {
       s = case kind.g of {
             Masc  => "овоj";
             Fem   => "оваа";
             Neutr => "ова"
           } ++
           kind.s ! Sg;
       a = ASg kind.g};
    That kind = {
       s = case kind.g of {
             Masc  => "оноj";
             Fem   => "онаа";
             Neutr => "она"
           } ++ 
           kind.s ! Sg;
       a = ASg kind.g};
    These kind = {s = "овие" ++ kind.s ! Pl; a = APl};
    Those kind = {s = "оние" ++ kind.s ! Pl; a = APl};
    Mod qual kind = {
       s = \\n => qual.s ! case n of {
                             Sg => ASg kind.g;
                             Pl => APl
                           } ++
                  kind.s ! n;
       g = kind.g};
    Wine  = {
       s = table {
             Sg => "вино";
             Pl => "вина"
       };
       g = Neutr};
    Cheese = {
       s = table {
             Sg => "сирење";
             Pl => "сирењa"
           };
       g = Neutr};
    Fish = {
       s = table {
             Sg => "риба";
             Pl => "риби"
       };
       g = Fem};
    Pizza = {
       s = table {
             Sg => "пица";
             Pl => "пици"
           };
       g = Fem
       };
    Very qual = {s = \\g => "многу" ++ qual.s ! g};
    Fresh = {
       s = table {
             ASg Masc  => "свеж";
             ASg Fem   => "свежа";
             ASg Neutr => "свежо";
             APl       => "свежи"}
       };
    Warm  = {
      s = table {
            ASg Masc  => "топол";
            ASg Fem   => "топла";
            ASg Neutr => "топло";
            APl       => "топли"}
      };
    Italian  = {
      s = table {
            ASg Masc  => "италијански";
            ASg Fem   => "италијанска";
            ASg Neutr => "италијанско";
            APl       => "италијански"}
      };
    Expensive  = {
       s = table {
             ASg Masc  => "скап";
             ASg Fem   => "скапа";
             ASg Neutr => "скапо";
             APl       => "скапи"}
       };
    Delicious  = {
       s = table {
             ASg Masc  => "вкусен";
             ASg Fem   => "вкусна";
             ASg Neutr => "вкусно";
             APl       => "вкусни"}
       };
    Boring  = {
       s = table {
             ASg Masc  => "досаден";
             ASg Fem   => "досадна";
             ASg Neutr => "досадно";
             APl       => "досадни"}
       };

param
    Gender = Masc | Fem | Neutr;
    Number = Sg | Pl;
    Agr = ASg Gender | APl;

}

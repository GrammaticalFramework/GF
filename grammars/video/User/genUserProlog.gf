-- File name User/general.Prolog.gf
--- the rest formarly known as User-general
-- is now considered shared-general

concrete genUserProlog of genUser = generalProlog ** open prologResource in {
lin
request a = {s = app "request" a.s };
}

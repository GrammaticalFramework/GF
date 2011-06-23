abstract ExtraPolAbs = Cat, Extra [AP,CN,Pron,ProDrop] ** 
{
	-- in Polish there exists a distinction between 
    -- attributes describing a quality of some object (e.g. cold water)
    -- and qualifying that object (e.g. sparkling water).
    -- attributes of the firs kind are called "przydawka wartościująca"
	-- and they are characterized in that the attribure precedes a noun.
	-- the other kind is called "przydawka gatunkująca vel klasyfikująca"
    -- and the attribute follows the noun.

fun QualifierCN : AP -> CN -> CN ;

}

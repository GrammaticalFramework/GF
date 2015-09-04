{-# LANGUAGE FlexibleInstances, FlexibleContexts #-}
-- | This is a layer on top of "Data.Binary" with its own 'Binary' class
-- and customised instances for 'Word', 'Int' and 'Double'.
-- The 'Int' and 'Word' instance use a variable-length encoding to save space
-- for small numbers. The 'Double' instance uses the standard IEEE754 encoding.
module PGF.Data.Binary (

    -- * The Binary class
      Binary(..)

    -- * The Get and Put monads
    , Get , Put, runPut

    -- * Useful helpers for writing instances
    , putWord8 , getWord8 , putWord16be , getWord16be

    -- * Binary serialisation
    , encode , decode

    -- * IO functions for serialisation
    , encodeFile , decodeFile

    , encodeFile_ , decodeFile_

    -- * Useful
    , Word8, Word16

    ) where


import Data.Word

import qualified Data.Binary as Bin
import Data.Binary.Put
import Data.Binary.Get
import Data.Binary.IEEE754 ( putFloat64be, getFloat64be)
import Control.Monad
import Control.Exception
import Foreign
import System.IO

import Data.ByteString.Lazy (ByteString)
import qualified Data.ByteString.Lazy as L

--import Data.Char    (chr,ord)
--import Data.List    (unfoldr)

-- And needed for the instances:
import qualified Data.ByteString as B
import qualified Data.Map        as Map
import qualified Data.Set        as Set
import qualified Data.IntMap     as IntMap
import qualified Data.IntSet     as IntSet
--import qualified Data.Ratio      as R

--import qualified Data.Tree as T

import Data.Array.Unboxed

------------------------------------------------------------------------

-- | The @Binary@ class provides 'put' and 'get', methods to encode and
-- decode a Haskell value to a lazy ByteString. It mirrors the Read and
-- Show classes for textual representation of Haskell types, and is
-- suitable for serialising Haskell values to disk, over the network.
--
-- For parsing and generating simple external binary formats (e.g. C
-- structures), Binary may be used, but in general is not suitable
-- for complex protocols. Instead use the Put and Get primitives
-- directly.
--
-- Instances of Binary should satisfy the following property:
--
-- > decode . encode == id
--
-- That is, the 'get' and 'put' methods should be the inverse of each
-- other. A range of instances are provided for basic Haskell types. 
--
class Binary t where
    -- | Encode a value in the Put monad.
    put :: t -> Put
    -- | Decode a value in the Get monad
    get :: Get t

------------------------------------------------------------------------
-- Wrappers to run the underlying monad

-- | Encode a value using binary serialisation to a lazy ByteString.
--
encode :: Binary a => a -> ByteString
encode = runPut . put
{-# INLINE encode #-}

-- | Decode a value from a lazy ByteString, reconstructing the original structure.
--
decode :: Binary a => ByteString -> a
decode = runGet get

------------------------------------------------------------------------
-- Convenience IO operations

-- | Lazily serialise a value to a file
--
-- This is just a convenience function, it's defined simply as:
--
-- > encodeFile f = B.writeFile f . encode
--
-- So for example if you wanted to compress as well, you could use:
--
-- > B.writeFile f . compress . encode
--
encodeFile :: Binary a => FilePath -> a -> IO ()
encodeFile f v = L.writeFile f (encode v)

encodeFile_ :: FilePath -> Put -> IO ()
encodeFile_ f m = L.writeFile f (runPut m)

-- | Lazily reconstruct a value previously written to a file.
--
-- This is just a convenience function, it's defined simply as:
--
-- > decodeFile f = return . decode =<< B.readFile f
--
-- So for example if you wanted to decompress as well, you could use:
--
-- > return . decode . decompress =<< B.readFile f
--
decodeFile :: Binary a => FilePath -> IO a
decodeFile f = bracket (openBinaryFile f ReadMode) hClose $ \h -> do
    s <- L.hGetContents h
    evaluate $ runGet get s

decodeFile_ :: FilePath -> Get a -> IO a
decodeFile_ f m = bracket (openBinaryFile f ReadMode) hClose $ \h -> do
    s <- L.hGetContents h
    evaluate $ runGet m s

------------------------------------------------------------------------
-- For ground types, the standard instances can be reused,
-- but for container types it would imply using
-- the standard instances for all types of values in the container...

instance Binary () where put=Bin.put; get=Bin.get
instance Binary Bool where put=Bin.put; get=Bin.get
instance Binary Word8 where put=Bin.put; get=Bin.get
instance Binary Word16 where put=Bin.put; get=Bin.get
instance Binary Char where put=Bin.put; get=Bin.get

-- -- GF doesn't need these:
--instance Binary Ordering where put=Bin.put; get=Bin.get
--instance Binary Word32 where put=Bin.put; get=Bin.get
--instance Binary Word64 where put=Bin.put; get=Bin.get
--instance Binary Int8 where put=Bin.put; get=Bin.get
--instance Binary Int16 where put=Bin.put; get=Bin.get
--instance Binary Int32 where put=Bin.put; get=Bin.get

--instance Binary Int64 where put=Bin.put; get=Bin.get -- needed by instance Binary ByteString

------------------------------------------------------------------------

-- Words are written as sequence of bytes. The last bit of each
-- byte indicates whether there are more bytes to be read
instance Binary Word where
    put i | i <=               0x7f = do put  a
          | i <=             0x3fff = do put (a .|. 0x80)
                                         put  b
          | i <=           0x1fffff = do put (a .|. 0x80)
                                         put (b .|. 0x80)
                                         put  c
          | i <=          0xfffffff = do put (a .|. 0x80)
                                         put (b .|. 0x80)
                                         put (c .|. 0x80)
                                         put  d
-- -- #if WORD_SIZE_IN_BITS < 64
          | otherwise               = do put (a .|. 0x80)
                                         put (b .|. 0x80)
                                         put (c .|. 0x80)
                                         put (d .|. 0x80)
                                         put  e
{-
-- Restricted to 32 bits even on 64-bit systems, so that negative
-- Ints are written as 5 bytes instead of 10 bytes (TH 2013-02-13)
--#else
          | i <=        0x7ffffffff = do put (a .|. 0x80)
                                         put (b .|. 0x80)
                                         put (c .|. 0x80)
                                         put (d .|. 0x80)
                                         put  e
          | i <=      0x3ffffffffff = do put (a .|. 0x80)
                                         put (b .|. 0x80)
                                         put (c .|. 0x80)
                                         put (d .|. 0x80)
                                         put (e .|. 0x80)
                                         put  f
          | i <=    0x1ffffffffffff = do put (a .|. 0x80)
                                         put (b .|. 0x80)
                                         put (c .|. 0x80)
                                         put (d .|. 0x80)
                                         put (e .|. 0x80)
                                         put (f .|. 0x80)
                                         put  g
          | i <=   0xffffffffffffff = do put (a .|. 0x80)
                                         put (b .|. 0x80)
                                         put (c .|. 0x80)
                                         put (d .|. 0x80)
                                         put (e .|. 0x80)
                                         put (f .|. 0x80)
                                         put (g .|. 0x80)
                                         put  h
          | i <=   0xffffffffffffff = do put (a .|. 0x80)
                                         put (b .|. 0x80)
                                         put (c .|. 0x80)
                                         put (d .|. 0x80)
                                         put (e .|. 0x80)
                                         put (f .|. 0x80)
                                         put (g .|. 0x80)
                                         put  h
          | i <= 0x7fffffffffffffff = do put (a .|. 0x80)
                                         put (b .|. 0x80)
                                         put (c .|. 0x80)
                                         put (d .|. 0x80)
                                         put (e .|. 0x80)
                                         put (f .|. 0x80)
                                         put (g .|. 0x80)
                                         put (h .|. 0x80)
                                         put  j
          | otherwise               = do put (a .|. 0x80)
                                         put (b .|. 0x80)
                                         put (c .|. 0x80)
                                         put (d .|. 0x80)
                                         put (e .|. 0x80)
                                         put (f .|. 0x80)
                                         put (g .|. 0x80)
                                         put (h .|. 0x80)
                                         put (j .|. 0x80)
                                         put  k
-- #endif
-}
          where
            a = fromIntegral (       i    .&. 0x7f) :: Word8
            b = fromIntegral (shiftR i  7 .&. 0x7f) :: Word8
            c = fromIntegral (shiftR i 14 .&. 0x7f) :: Word8
            d = fromIntegral (shiftR i 21 .&. 0x7f) :: Word8
            e = fromIntegral (shiftR i 28 .&. 0x7f) :: Word8
{-
            f = fromIntegral (shiftR i 35 .&. 0x7f) :: Word8
            g = fromIntegral (shiftR i 42 .&. 0x7f) :: Word8
            h = fromIntegral (shiftR i 49 .&. 0x7f) :: Word8
            j = fromIntegral (shiftR i 56 .&. 0x7f) :: Word8
            k = fromIntegral (shiftR i 63 .&. 0x7f) :: Word8
-}
    get = do i <- getWord8
             (if i <= 0x7f
                then return (fromIntegral i)
                else do n <- get
                        return $ (n `shiftL` 7) .|. (fromIntegral (i .&. 0x7f)))

-- Int has the same representation as Word
instance Binary Int where
    put i   = put (fromIntegral i :: Word)
    get     = liftM toInt32 (get :: Get Word)
      where
       -- restrict to 32 bits (for PGF portability, TH 2013-02-13)
       toInt32 w = fromIntegral (fromIntegral w::Int32)::Int

------------------------------------------------------------------------
-- 
-- Portable, and pretty efficient, serialisation of Integer
--

-- Fixed-size type for a subset of Integer
--type SmallInt = Int32

-- Integers are encoded in two ways: if they fit inside a SmallInt,
-- they're written as a byte tag, and that value.  If the Integer value
-- is too large to fit in a SmallInt, it is written as a byte array,
-- along with a sign and length field.
{-
instance Binary Integer where

    {-# INLINE put #-}
    put n | n >= lo && n <= hi = do
        putWord8 0
        put (fromIntegral n :: SmallInt)  -- fast path
     where
        lo = fromIntegral (minBound :: SmallInt) :: Integer
        hi = fromIntegral (maxBound :: SmallInt) :: Integer

    put n = do
        putWord8 1
        put sign
        put (unroll (abs n))         -- unroll the bytes
     where
        sign = fromIntegral (signum n) :: Word8

    {-# INLINE get #-}
    get = do
        tag <- get :: Get Word8
        case tag of
            0 -> liftM fromIntegral (get :: Get SmallInt)
            _ -> do sign  <- get
                    bytes <- get
                    let v = roll bytes
                    return $! if sign == (1 :: Word8) then v else - v

--
-- Fold and unfold an Integer to and from a list of its bytes
--
unroll :: Integer -> [Word8]
unroll = unfoldr step
  where
    step 0 = Nothing
    step i = Just (fromIntegral i, i `shiftR` 8)

roll :: [Word8] -> Integer
roll   = foldr unstep 0
  where
    unstep b a = a `shiftL` 8 .|. fromIntegral b

instance (Binary a,Integral a) => Binary (R.Ratio a) where
    put r = put (R.numerator r) >> put (R.denominator r)
    get = liftM2 (R.%) get get
-}

------------------------------------------------------------------------
-- Instances for the first few tuples

instance (Binary a, Binary b) => Binary (a,b) where
    put (a,b)           = put a >> put b
    get                 = liftM2 (,) get get

instance (Binary a, Binary b, Binary c) => Binary (a,b,c) where
    put (a,b,c)         = put a >> put b >> put c
    get                 = liftM3 (,,) get get get

instance (Binary a, Binary b, Binary c, Binary d) => Binary (a,b,c,d) where
    put (a,b,c,d)       = put a >> put b >> put c >> put d
    get                 = liftM4 (,,,) get get get get

instance (Binary a, Binary b, Binary c, Binary d, Binary e) => Binary (a,b,c,d,e) where
    put (a,b,c,d,e)     = put a >> put b >> put c >> put d >> put e
    get                 = liftM5 (,,,,) get get get get get

-- 
-- and now just recurse:
--

instance (Binary a, Binary b, Binary c, Binary d, Binary e, Binary f)
        => Binary (a,b,c,d,e,f) where
    put (a,b,c,d,e,f)   = put (a,(b,c,d,e,f))
    get                 = do (a,(b,c,d,e,f)) <- get ; return (a,b,c,d,e,f)

instance (Binary a, Binary b, Binary c, Binary d, Binary e, Binary f, Binary g)
        => Binary (a,b,c,d,e,f,g) where
    put (a,b,c,d,e,f,g) = put (a,(b,c,d,e,f,g))
    get                 = do (a,(b,c,d,e,f,g)) <- get ; return (a,b,c,d,e,f,g)

instance (Binary a, Binary b, Binary c, Binary d, Binary e,
          Binary f, Binary g, Binary h)
        => Binary (a,b,c,d,e,f,g,h) where
    put (a,b,c,d,e,f,g,h) = put (a,(b,c,d,e,f,g,h))
    get                   = do (a,(b,c,d,e,f,g,h)) <- get ; return (a,b,c,d,e,f,g,h)

instance (Binary a, Binary b, Binary c, Binary d, Binary e,
          Binary f, Binary g, Binary h, Binary i)
        => Binary (a,b,c,d,e,f,g,h,i) where
    put (a,b,c,d,e,f,g,h,i) = put (a,(b,c,d,e,f,g,h,i))
    get                     = do (a,(b,c,d,e,f,g,h,i)) <- get ; return (a,b,c,d,e,f,g,h,i)

instance (Binary a, Binary b, Binary c, Binary d, Binary e,
          Binary f, Binary g, Binary h, Binary i, Binary j)
        => Binary (a,b,c,d,e,f,g,h,i,j) where
    put (a,b,c,d,e,f,g,h,i,j) = put (a,(b,c,d,e,f,g,h,i,j))
    get                       = do (a,(b,c,d,e,f,g,h,i,j)) <- get ; return (a,b,c,d,e,f,g,h,i,j)

------------------------------------------------------------------------
-- Container types

instance Binary a => Binary [a] where
    put l  = put (length l) >> mapM_ put l
    get    = do n <- get :: Get Int
                xs <- replicateM n get
                return xs

instance (Binary a) => Binary (Maybe a) where
    put Nothing  = putWord8 0
    put (Just x) = putWord8 1 >> put x
    get = do
        w <- getWord8
        case w of
            0 -> return Nothing
            _ -> liftM Just get

instance (Binary a, Binary b) => Binary (Either a b) where
    put (Left  a) = putWord8 0 >> put a
    put (Right b) = putWord8 1 >> put b
    get = do
        w <- getWord8
        case w of
            0 -> liftM Left  get
            _ -> liftM Right get

------------------------------------------------------------------------
-- ByteStrings (have specially efficient instances)

instance Binary B.ByteString where
    put bs = do put (B.length bs)
                putByteString bs
    get    = get >>= getByteString

--
-- Using old versions of fps, this is a type synonym, and non portable
-- 
-- Requires 'flexible instances'
--
{-
instance Binary ByteString where
    put bs = do put (fromIntegral (L.length bs) :: Int)
                putLazyByteString bs
    get    = get >>= getLazyByteString
-}
------------------------------------------------------------------------
-- Maps and Sets

instance (Ord a, Binary a) => Binary (Set.Set a) where
    put s = put (Set.size s) >> mapM_ put (Set.toAscList s)
    get   = liftM Set.fromDistinctAscList get

instance (Ord k, Binary k, Binary e) => Binary (Map.Map k e) where
    put m = put (Map.size m) >> mapM_ put (Map.toAscList m)
    get   = liftM Map.fromDistinctAscList get

instance Binary IntSet.IntSet where
    put s = put (IntSet.size s) >> mapM_ put (IntSet.toAscList s)
    get   = liftM IntSet.fromDistinctAscList get

instance (Binary e) => Binary (IntMap.IntMap e) where
    put m = put (IntMap.size m) >> mapM_ put (IntMap.toAscList m)
    get   = liftM IntMap.fromDistinctAscList get

------------------------------------------------------------------------
-- Floating point

-- instance Binary Double where
--     put d = put (decodeFloat d)
--     get   = liftM2 encodeFloat get get

instance Binary Double where
    put = putFloat64be
    get = getFloat64be
{-
instance Binary Float where
    put f = put (decodeFloat f)
    get   = liftM2 encodeFloat get get
-}
------------------------------------------------------------------------
-- Trees
{-
instance (Binary e) => Binary (T.Tree e) where
    put (T.Node r s) = put r >> put s
    get = liftM2 T.Node get get
-}
------------------------------------------------------------------------
-- Arrays

instance (Binary i, Ix i, Binary e) => Binary (Array i e) where
    put a = do
        put (bounds a)
        put (rangeSize $ bounds a) -- write the length
        mapM_ put (elems a)        -- now the elems.
    get = do
        bs <- get
        n  <- get                  -- read the length
        xs <- replicateM n get     -- now the elems.
        return (listArray bs xs)

--
-- The IArray UArray e constraint is non portable. Requires flexible instances
--
instance (Binary i, Ix i, Binary e, IArray UArray e) => Binary (UArray i e) where
    put a = do
        put (bounds a)
        put (rangeSize $ bounds a) -- now write the length
        mapM_ put (elems a)
    get = do
        bs <- get
        n  <- get
        xs <- replicateM n get
        return (listArray bs xs)

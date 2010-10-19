% Copyright (C) 2009 John Millikin <jmillikin@gmail.com>
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

\ignore{
\begin{code}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Data.Binary.IEEE754 (
	-- * Parsing
	  getFloat16be, getFloat16le
	, getFloat32be, getFloat32le
	, getFloat64be, getFloat64le
	
	-- * Serializing
	, putFloat32be, putFloat32le
	, putFloat64be, putFloat64le
) where

import Data.Bits ((.&.), (.|.), shiftL, shiftR, Bits)
import Data.Word (Word8)
import Data.List (foldl')

import qualified Data.ByteString as B
import Data.Binary.Get (Get, getByteString)
import Data.Binary.Put (Put, putByteString)
\end{code}
}

\section{Parsing}

\subsection{Public interface}

\begin{code}
getFloat16be :: Get Float
getFloat16be = getFloat (ByteCount 2) splitBytes
\end{code}

\begin{code}
getFloat16le :: Get Float
getFloat16le = getFloat (ByteCount 2) $ splitBytes . reverse
\end{code}

\begin{code}
getFloat32be :: Get Float
getFloat32be = getFloat (ByteCount 4) splitBytes
\end{code}

\begin{code}
getFloat32le :: Get Float
getFloat32le = getFloat (ByteCount 4) $ splitBytes . reverse
\end{code}

\begin{code}
getFloat64be :: Get Double
getFloat64be = getFloat (ByteCount 8) splitBytes
\end{code}

\begin{code}
getFloat64le :: Get Double
getFloat64le = getFloat (ByteCount 8) $ splitBytes . reverse
\end{code}

\subsection{Implementation}

Split the raw byte array into (sign, exponent, significand) components.
The exponent and signifcand are drawn directly from the bits in the
original float, and have not been unbiased or otherwise modified.

\begin{code}
splitBytes :: [Word8] -> RawFloat
splitBytes bs = RawFloat width sign exp' sig expWidth sigWidth where
	width = ByteCount (length bs)
	nBits = bitsInWord8 bs
	sign = if head bs .&. 0x80 == 0x80
		then Negative
		else Positive
	
	expStart = 1
	expWidth = exponentWidth nBits
	expEnd = expStart + expWidth
	exp' = Exponent . fromIntegral $ bitSlice bs expStart expEnd
	
	sigWidth = nBits - expEnd
	sig  = Significand $ bitSlice bs expEnd nBits
\end{code}

\subsubsection{Encodings and special values}

The next step depends on the value of the exponent $e$, size of the
exponent field in bits $w$, and value of the significand.

\begin{table}[h]
\begin{center}
\begin{tabular}{lrl}
\toprule
Exponent                & Significand & Format \\
\midrule
$0$                     & $0$           & Zero \\
$0$                     & $> 0$         & Denormalised \\
$1 \leq e \leq 2^w - 2$ & \textit{any} & Normalised \\
$2^w-1$                 & $0$           & Infinity \\
$2^w-1$                 & $> 0$         & NaN \\
\bottomrule
\end{tabular}
\end{center}
\end{table}

There's no built-in literals for Infinity or NaN, so they
are constructed using the {\tt Read} instances for {\tt Double} and
{\tt Float}.

\begin{code}
merge :: (Read a, RealFloat a) => RawFloat -> a
merge f@(RawFloat _ _ e sig eWidth _)
	| e == 0 = if sig == 0
		then 0.0
		else denormalised f
	| e == eMax - 1 = if sig == 0
		then read "Infinity"
		else read "NaN"
	| otherwise = normalised f
	where eMax = 2 `pow` eWidth
\end{code}

If a value is normalised, its significand has an implied {\tt 1} bit
in its most-significant bit. The significand must be adjusted by
this value before being passed to {\tt encodeField}.

\begin{code}
normalised :: RealFloat a => RawFloat -> a
normalised f = encodeFloat fraction exp' where
	Significand sig = rawSignificand f
	Exponent exp' = unbiased - sigWidth
	
	fraction = sig + (1 `bitShiftL` rawSignificandWidth f)
	
	sigWidth = fromIntegral $ rawSignificandWidth f
	unbiased = unbias (rawExponent f) (rawExponentWidth f)
\end{code}

For denormalised values, the implied {\tt 1} bit is the least-significant
bit of the exponent.

\begin{code}
denormalised :: RealFloat a => RawFloat -> a
denormalised f = encodeFloat sig exp' where
	Significand sig = rawSignificand f
	Exponent exp' = unbiased - sigWidth + 1
	
	sigWidth = fromIntegral $ rawSignificandWidth f
	unbiased = unbias (rawExponent f) (rawExponentWidth f)
\end{code}

By composing {\tt splitBytes} and {\tt merge}, the absolute value of the
float is calculated. Before being returned to the calling function, it
must be signed appropriately.

\begin{code}
getFloat :: (Read a, RealFloat a) => ByteCount
            -> ([Word8] -> RawFloat) -> Get a
getFloat (ByteCount width) parser = do
	raw <- fmap (parser . B.unpack) $ getByteString width
	let absFloat = merge raw
	return $ case rawSign raw of
		Positive ->  absFloat
		Negative -> -absFloat
\end{code}

\section{Serialising}

\subsection{Public interface}

\begin{code}
putFloat32be :: Float -> Put
putFloat32be = putFloat (ByteCount 4) id
\end{code}

\begin{code}
putFloat32le :: Float -> Put
putFloat32le = putFloat (ByteCount 4) reverse
\end{code}

\begin{code}
putFloat64be :: Double -> Put
putFloat64be = putFloat (ByteCount 8) id
\end{code}

\begin{code}
putFloat64le :: Double -> Put
putFloat64le = putFloat (ByteCount 8) reverse
\end{code}

\subsection{Implementation}

Serialisation is similar to parsing. First, the float is converted to
a structure representing raw bitfields. The values returned from
{\tt decodeFloat} are clamped to their expected lengths before being
stored in the {\tt RawFloat}.

\begin{code}
splitFloat :: RealFloat a => ByteCount -> a -> RawFloat
splitFloat width x = raw where
	raw = RawFloat width sign clampedExp clampedSig expWidth sigWidth
	sign = if isNegativeNaN x || isNegativeZero x || x < 0
		then Negative
		else Positive
	clampedExp = clamp expWidth exp'
	clampedSig = clamp sigWidth sig
	(exp', sig) = case (dFraction, dExponent, biasedExp) of
		(0, 0, _) -> (0, 0)
		(_, _, 0) -> (0, Significand $ truncatedSig + 1)
		_         -> (biasedExp, Significand truncatedSig)
	expWidth = exponentWidth $ bitCount width
	sigWidth = bitCount width - expWidth - 1 -- 1 for sign bit
	
	(dFraction, dExponent) = decodeFloat x
	
	rawExp = Exponent $ dExponent + fromIntegral sigWidth
	biasedExp = bias rawExp expWidth
	truncatedSig = abs dFraction - (1 `bitShiftL` sigWidth)
\end{code}

Then, the {\tt RawFloat} is converted to a list of bytes by mashing all
the fields together into an {\tt Integer}, and chopping up that integer
in 8-bit blocks.

\begin{code}
rawToBytes :: RawFloat -> [Word8]
rawToBytes raw = integerToBytes mashed width where
	RawFloat width sign exp' sig expWidth sigWidth = raw
	sign' :: Word8
	sign' = case sign of
		Positive -> 0
		Negative -> 1
	mashed = mashBits sig sigWidth .
	         mashBits exp' expWidth .
	         mashBits sign' 1 $ 0
\end{code}

{\tt clamp}, given a maximum bit count and a value, will strip any 1-bits
in positions above the count.

\begin{code}
clamp :: Bits a => BitCount -> a -> a
clamp = (.&.) . mask where
	mask 1 = 1
	mask n | n > 1 = (mask (n - 1) `shiftL` 1) + 1
	mask _ = undefined
\end{code}

For merging the fields, just shift the starting integer over a bit and
then \textsc{or} it with the next value. The weird parameter order allows
easy composition.

\begin{code}
mashBits :: (Bits a, Integral a) => a -> BitCount -> Integer -> Integer
mashBits _ 0 x = x
mashBits y n x = (x `bitShiftL` n) .|. fromIntegral y
\end{code}

Given an integer, read it in 255-block increments starting from the LSB.
Each increment is converted to a byte and added to the final list.

\begin{code}
integerToBytes :: Integer -> ByteCount -> [Word8]
integerToBytes _ 0 = []
integerToBytes x n = bytes where
	bytes = integerToBytes (x `shiftR` 8) (n - 1) ++ [step]
	step = fromIntegral x .&. 0xFF
\end{code}

Finally, the raw parsing is wrapped up in {\tt Put}. The second parameter
allows the same code paths to be used for little- and big-endian
serialisation.

\begin{code}
putFloat :: (RealFloat a) => ByteCount -> ([Word8] -> [Word8]) -> a -> Put
putFloat width f x = putByteString $ B.pack bytes where
	bytes = f . rawToBytes . splitFloat width $ x
\end{code}

\section{Raw float components}

Information about the raw bit patterns in the float is stored in
{\tt RawFloat}, so they don't have to be passed around to the various
format cases. The exponent should be biased, and the significand
shouldn't have it's implied MSB (if applicable).

\begin{code}
data RawFloat = RawFloat
	{ rawWidth            :: ByteCount
	, rawSign             :: Sign
	, rawExponent         :: Exponent
	, rawSignificand      :: Significand
	, rawExponentWidth    :: BitCount
	, rawSignificandWidth :: BitCount
	}
	deriving (Show)
\end{code}

\section{Exponents}

Calculate the proper size of the exponent field, in bits, given the
size of the full structure.

\begin{code}
exponentWidth :: BitCount -> BitCount
exponentWidth k
	| k == 16         = 5
	| k == 32         = 8
	| k `mod` 32 == 0 = ceiling (4 * logBase 2 (fromIntegral k)) - 13
	| otherwise       = error "Invalid length of floating-point value"
\end{code}

\begin{code}
bias :: Exponent -> BitCount -> Exponent
bias e eWidth = e - (1 - (2 `pow` (eWidth - 1)))
\end{code}

\begin{code}
unbias :: Exponent -> BitCount -> Exponent
unbias e eWidth = e + 1 - (2 `pow` (eWidth - 1))
\end{code}

\section{Byte and bit counting}

\begin{code}
data Sign = Positive | Negative
	deriving (Show)

newtype Exponent = Exponent Int
	deriving (Show, Eq, Num, Ord, Real, Enum, Integral, Bits)

newtype Significand = Significand Integer
	deriving (Show, Eq, Num, Ord, Real, Enum, Integral, Bits)

newtype BitCount = BitCount Int
	deriving (Show, Eq, Num, Ord, Real, Enum, Integral)

newtype ByteCount = ByteCount Int
	deriving (Show, Eq, Num, Ord, Real, Enum, Integral)

bitCount :: ByteCount -> BitCount
bitCount (ByteCount x) = BitCount (x * 8)

bitsInWord8 :: [Word8] -> BitCount
bitsInWord8 = bitCount . ByteCount . length

bitShiftL :: (Bits a) => a -> BitCount -> a
bitShiftL x (BitCount n) = shiftL x n

bitShiftR :: (Bits a) => a -> BitCount -> a
bitShiftR x (BitCount n) = shiftR x n
\end{code}

\section{Utility}

Considering a byte list as a sequence of bits, slice it from start
inclusive to end exclusive, and return the resulting bit sequence as an
integer.

\begin{code}
bitSlice :: [Word8] -> BitCount -> BitCount -> Integer
bitSlice bs = sliceInt (foldl' step 0 bs) bitCount' where
	step acc w     = shiftL acc 8 + fromIntegral w
	bitCount'      = bitsInWord8 bs
\end{code}

Slice a single integer by start and end bit location

\begin{code}
sliceInt :: Integer -> BitCount -> BitCount -> BitCount -> Integer
sliceInt x xBitCount s e = fromIntegral sliced where
	sliced = (x .&. startMask) `bitShiftR` (xBitCount - e)
	startMask = n1Bits (xBitCount - s)
	n1Bits n  = (2 `pow` n) - 1
\end{code}

Integral version of {\tt (**)}

\begin{code}
pow :: (Integral a, Integral b, Integral c) => a -> b -> c
pow b e = floor $ fromIntegral b ** fromIntegral e
\end{code}

Detect whether a float is {\tt $-$NaN}

\begin{code}
isNegativeNaN :: RealFloat a => a -> Bool
isNegativeNaN x = isNaN x && (floor x > 0)
\end{code}

{-# LANGUAGE UndecidableInstances #-}
newtype Endoo a = Endoo {appEndoo :: a -> a}

-- chatgpt 4.0 isn't so reliable as it seems. It has given a bad implementation for Endo, as well as it's function of mappend
instance Semigroup (Endoo a) => Monoid (Endoo a) where
    mempty :: Endoo a
    mempty = Endoo id
    mappend :: Endoo a -> Endoo a -> Endoo a
    mappend x y = Endoo (appEndoo y . appEndoo x)
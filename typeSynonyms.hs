import Data.List (find)
{-
task: make a phonebook data type (with Synonym syntax)
-}

type Name = String
type PhoneNumber = String
type PhoneBook = [(Name, PhoneNumber)]

inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool
inPhoneBook name pnumber pbook = (name, pnumber) `elem` pbook

{-
take: define an AssocList type with Synonym syntax
-}

type AssocList k v = [(k, v)]

findV :: (Eq k) => k -> AssocList k v -> Maybe v
findV key list = 
    case find (\(k, _) -> k == key) list of 
        Nothing -> Nothing
        (Just (_, v)) -> Just v
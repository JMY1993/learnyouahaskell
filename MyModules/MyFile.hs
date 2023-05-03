module MyModules.MyFile (withFile') where

import System.IO (Handle, IOMode, hClose, openFile)

withFile' :: FilePath -> IOMode -> (Handle -> IO a) -> IO a
withFile' fPath mode f = do
  handle <- openFile fPath mode
  result <- f handle
  hClose handle
  return result
module Clang.File
( FFI.UnsavedFile
, FFI.File
, getName
, getPOSIXTime
, getUTCTime
, getFile
) where

import Control.Monad.IO.Class
import Control.Applicative ((<$>))
import Data.Time.Clock.POSIX (POSIXTime, posixSecondsToUTCTime)
import Data.Time.Clock (UTCTime)

import qualified Clang.Internal.FFI as FFI
import Clang.Monad

getName :: FFI.File -> ClangApp FFI.CXString
getName f = liftIO $ FFI.getFileName f

getPOSIXTime :: FFI.File -> ClangApp POSIXTime
getPOSIXTime f = liftIO $ realToFrac <$> FFI.getFileTime f

getUTCTime :: FFI.File -> ClangApp UTCTime
getUTCTime f = liftIO $ posixSecondsToUTCTime . realToFrac <$> FFI.getFileTime f

getFile :: FFI.TranslationUnit -> FilePath -> ClangApp FFI.File
getFile t f = liftIO $ FFI.getFile t f

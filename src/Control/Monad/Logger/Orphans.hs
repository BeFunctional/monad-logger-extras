{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

-- |
-- Description: Orphan instances for monad-logger's LoggingT
module Control.Monad.Logger.Orphans where

-- add a cpp guard to avoid orphan instances on ghc <= 8.10
#if !MIN_VERSION_monad_logger(0,3,36)
import Control.Applicative (Alternative (..))
import Control.Monad (MonadPlus (..))
import Control.Monad.Logger
import Control.Monad.Trans (lift)


instance (Monad m, Alternative m) => Alternative (LoggingT m) where
  empty = lift empty
  a <|> b = LoggingT $ \f -> runLoggingT a f <|> runLoggingT b f

instance (Monad m, Alternative m) => MonadPlus (LoggingT m)
#endif

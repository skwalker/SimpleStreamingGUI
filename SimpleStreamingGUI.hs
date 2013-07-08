module Main where 

{-
Goal: In the background, generate data at some rate and feed them
into a shared TChan.
Concurrently, run a GUI that displays the data coming in, along with
some running statistic on the incoming data.
GUI has buttons that turn on and off 'listening' to the data in the TChan.
(Side-question, what should happen to TChan data when GUI isn't listening?
Continues to build up on the FIFO queue?  Or silently dropped?)
-}

import Control.Monad (forM_)
import Control.Concurrent(forkIO, threadDelay)
import Control.Concurrent.STM

main :: IO ()
main = do
  dataChan <- newTChanIO
  forkIO (genData dataChan)
  runGUI dataChan

genData :: TChan Int -> IO ()
genData tc = forM_ [0..] $ \i -> do
  atomically $ writeTChan tc i
  threadDelay 500000
  
runGUI :: TChan Int -> IO ()
runGUI = undefined  -- TODO!
  

runViewerGui :: TChan Int -> IO ()
runViewerGui = undefined

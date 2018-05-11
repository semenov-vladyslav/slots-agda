module slots.defs where

open import slots.imports

record config
  : Set where

  field
    n : ℕ -- reel count
    m : ℕ -- fruit count

  Win/Bet = ℕ -- win per 1 bet
  Fruit = Fin m
  ReelNo = Fin n
  Reel = List Fruit
  Reels = Vec Reel n
  WinLine = Vec Win/Bet n
  WinTable = Vec WinLine m
  Line = Vec Fruit n

record game (cfg : config) : Set where
  open config cfg

  field
    reels : Reels
    winTable : WinTable


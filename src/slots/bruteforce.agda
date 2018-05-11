open import slots.imports
open import slots.defs

module slots.bruteforce {cfg : config}(g : game cfg) where

open config cfg
open game g

total : ℕ
total = V.foldl _ (λ i r → i * L.length r) 1 reels

lineWin : Line → Win/Bet
lineWin [] = 0
lineWin (f₀ ∷ fs) = lineWin′ w ws fs where
  winLine = V.lookup f₀ winTable
  w = V.head winLine
  ws = V.tail winLine

  lineWin′ : ∀ {n} →
    Win/Bet → Vec Win/Bet n → Vec Fruit n → Win/Bet
  lineWin′ w [] [] = w
  lineWin′ w (w′ ∷ ws) (f ∷ fs) with f₀ F.≟ f
  ... | yes p = lineWin′ w′ ws fs
  ... | no ¬p = w

allLines : List Line
allLines = V.foldr (List ∘ Vec Fruit)
  (λ r → L.concatMap λ l → L.map (_∷ l) r)
  ([] ∷ []) reels

win : ℕ
win = L.sum ∘ L.map lineWin $ allLines

rtp : ℕ × ℕ
rtp = win , total

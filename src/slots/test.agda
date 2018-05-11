module slots.test where

open import slots.imports
open import slots.defs using (config ; game)
open import slots.bruteforce using (rtp)

c : config
c = record { n = 3 ; m = 4 }

g : game c
g = record { reels = reels ; winTable = winTable } where
  open config c
  reel : Reel
  reel = # 1 ∷ # 1 ∷ # 1 ∷ # 0 ∷ []
  reel′ : Reel
  reel′ = # 1 ∷ # 1 ∷ # 2 ∷ # 0 ∷ []
  reel″ : Reel
  reel″ = # 1 ∷ # 3 ∷ # 1 ∷ # 0 ∷ []

  reels : Reels
  reels =
    reel ∷
    reel′ ∷
    reel″ ∷
    []

  winTable : WinTable
  winTable =
    (0 ∷ 0 ∷ 0 ∷ []) ∷
    (0 ∷ 1 ∷ 2 ∷ []) ∷
    (0 ∷ 0 ∷ 0 ∷ []) ∷
    (0 ∷ 0 ∷ 0 ∷ []) ∷
    []

% : ℕ × ℕ
% = rtp g

%-prf : % ≡ (36 , 64)
%-prf = refl



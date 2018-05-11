open import slots.imports
open import slots.defs

module slots.packed {cfg : config}(g : game cfg) where

open config cfg
open game g

LineCombinations = Vec ℕ n
ReelCombinations = Vec LineCombinations m

PackedLine = Fruit × ReelNo
PackedReel = Vec ℕ m
PackedReels = Vec PackedReel n

packReel : Reel → PackedReel
packReel = L.foldl (λ r f → V.zipWith _+_ r (z V.[ f ]≔ 1)) z where
  z = V.replicate 0

packReels : Reels → PackedReels
packReels = V.map packReel

packedLength : PackedReel → ℕ
packedLength = V.foldl _ _+_ 0

packedTotal : PackedReels → ℕ
packedTotal = V.foldl _ (λ i r → i * packedLength r) 1

packedLineWin : PackedLine → WinTable → ℕ
packedLineWin (f , r) = V.lookup r ∘ V.lookup f

rproducts : ∀ {n} → Vec ℕ n → Vec ℕ n
rproducts = V.foldr (Vec ℕ) (λ k ks → k ∷ V.map (k N.*_) ks) []
lproducts : ∀ {n} → Vec ℕ n → Vec ℕ n
lproducts = V.foldl (Vec ℕ) (λ ks k → k ∷ V.map (k N.*_) ks) []

fruitLineCombinations : PackedReels → Fruit → LineCombinations
fruitLineCombinations rs f = {!!} where
  g′ : PackedReel → ℕ × ℕ
  g′ r = #f , #f̅ where
    #f : ℕ
    #f = V.lookup f r
    #f̅ : ℕ
    #f̅ = V.sum r N.∸ #f
  fs,f̅s = V.unzip (V.map g′ rs)
  fs : Vec ℕ n
  fs = rproducts (proj₁ fs,f̅s)
  -- ts = lproducts 
  f̅s : Vec ℕ n
  f̅s = proj₂ fs,f̅s
  -- f₀ f₁ f₂ f₃
  -- f̅₀ f̅₁ f̅₂ f̅₃
  -- t₀ t₁ t₂ t₃
  -- f₀ f̅₁ t₂ t₃ | 1
  -- f₀ f₁ f̅₂ t₃ | 2
  -- f₀ f₁ f₂ f̅₃ | 3
  -- f₀ f₁ f₂ f₃ | 4

fruitReelCombinations : PackedReels → ReelCombinations
fruitReelCombinations rs = V.tabulate (fruitLineCombinations rs)

sum2 : ∀ {n}{A : Set}{B : Set} → (A → B → ℕ) → Vec A n → Vec B n → ℕ
sum2 f as bs = V.sum (V.zipWith f as bs)

rtp : WinTable → ReelCombinations → ℕ
rtp = sum2 (sum2 _*_)


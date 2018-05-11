module slots.imports where

open import Data.Nat public using (ℕ ; zero ; suc ; _+_ ; _*_)
open import Data.Fin public using (Fin ; zero ; suc ; #_)
open import Data.List public using (List ; [] ; _∷_)
open import Data.Vec public using (Vec ; [] ; _∷_)
open import Data.Product public using (_×_ ; _,_ ; proj₁ ; proj₂)
open import Function public using (const ; _∘_ ; _$_ ; case_of_)
open import Relation.Nullary public using (Dec ; yes ; no)
open import Relation.Binary.PropositionalEquality public using (_≡_ ; refl)

module N = Data.Nat
module F = Data.Fin
module L = Data.List
module V = Data.Vec
module P = Data.Product

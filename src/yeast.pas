{
  Pizza Dough Calculator - Yeast unit

  This file includes an implementation of a yeast calculation algorithm
  inspired by the RafCalc project:
  https://github.com/Rafbor42/RafCalc

  Original author:
  Copyright (C) Raphael Borrelli (@Rafbor)

  Adaptation and integration:
  Copyright (C) 2026 Damien MARTIN

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

  See the GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see <https://www.gnu.org/licenses/>.
}

unit yeast;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Math;

function CalcYeast(
  Flour,                  // g
  Hydration,              // %
  SaltPerLiter,           // g/L
  Temp,                   // °C
  TimeHours: Double)      // h
: Double;

implementation

{*
  Legal informations:

  This function use the formulas from Raphael Borrelli (@Rafbor) under the GPLv3 license
  See: https://github.com/Rafbor42/RafCalc/blob/main/Calc.cs
*}
function CalcYeast(Flour, Hydration, SaltPerLiter, Temp, TimeHours: Double): Double;
var
  Coef: Double;
  HydFactor: Double;
begin
  // coefficient par défaut de l'app
  Coef := 2250;

  // facteur hydratation (très important !)
  HydFactor := -80 + 4.2 * Hydration - 0.0305 * Power(Hydration, 2);

  Result := Flour * Coef;
  Result := Result * (1 + SaltPerLiter / 200);

  Result := Result / (
    HydFactor *
    Power(Temp, 2.5) *
    Power(TimeHours, 1.2)
  );

  { Formula uses Japi2, but to be more error prone, we adjust the quantity based on the fermentation duration. }

  if TimeHours <= 6 then
    Result := Result * 1.0
  else if TimeHours <= 24 then
    Result := Result * 1.8
  else
    Result := Result * 2.2;

end;

end.


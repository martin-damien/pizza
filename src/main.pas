{
  Pizza Dough Calculator - Main Form

  This file contains an implementation inspired by the RafCalc project
  (https://github.com/ - if you have exact repo, you can add it here)

  Copyright (C) 2026 Damien MARTIN

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see <https://www.gnu.org/licenses/>.
}

unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Spin, Menus, Buttons, Yeast;

type

  { TMainForm }

  TYeast = (Fresh, DryActive);

  TMainForm = class(TForm)
    CalculateButton: TBitBtn;
    DoughGroupBox: TGroupBox;
    QuantitiesGroupBox: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Quantities_SaltYeast_Panel: TPanel;
    Quantities_FloorWater_Panel: TPanel;
    YeastResultLabel: TLabel;
    FlourResultLabel: TLabel;
    WaterResultLabel: TLabel;
    SaltResultLabel: TLabel;
    LeftPanel: TPanel;
    ProportionsGroupBox: TGroupBox;
    FermentationGroupBox: TGroupBox;
    NumberOfPizzaLabel: TLabel;
    DoughWeightLabel: TLabel;
    WaterLabel: TLabel;
    SaltLabel: TLabel;
    FermentationDurationLabel: TLabel;
    TemperatureLabel: TLabel;
    DryYeastRadioButton: TRadioButton;
    FreshYeastRadioButton: TRadioButton;
    NumberOfPizzaSpinEdit: TSpinEdit;
    DoughWeightSpinEdit: TSpinEdit;
    WaterSpinEdit: TSpinEdit;
    SaltSpinEdit: TSpinEdit;
    FermentationDurationSpinEdit: TSpinEdit;
    TemperatureSpinEdit: TSpinEdit;
    YeastRadioGroup: TRadioGroup;
    procedure CalculateButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    procedure Calculate;
  public

  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.Calculate;
var
  Flour, Water, Salt, Yeast, Hydration, SaltRatio, YeastRatio, YeastPercent, SaltPerLiter: Real;
  TotalDough, NumberOfPizza, DoughWeight, WaterPercent, SaltPercent, FermentationDuration, RoomTemperature: Integer;
  yeastType: TYeast;
begin
     { Retrieve user data }

    NumberOfPizza := NumberOfPizzaSpinEdit.Value;
    DoughWeight := DoughWeightSpinEdit.Value;
    WaterPercent := WaterSpinEdit.Value;
    SaltPercent := SaltSpinEdit.Value;
    FermentationDuration := FermentationDurationSpinEdit.Value;
    RoomTemperature := TemperatureSpinEdit.Value;

    if DryYeastRadioButton.Checked then
       yeastType := DryActive;
    if FreshYeastRadioButton.Checked then
       yeastType := Fresh;

    { Calculate quantities }

    TotalDough := NumberOfPizza * DoughWeight;
    Hydration := WaterPercent / 100;
    SaltRatio := SaltPercent / 100;

    SaltPerLiter := SaltPercent * 10 * Hydration;




    Flour := TotalDough / ( 1 + Hydration + SaltRatio );
    Water := Flour * Hydration;
    Salt := Flour * SaltRatio;
    Yeast := CalcYeast(Flour, WaterPercent, SaltPerLiter, RoomTemperature, FermentationDuration);

    { Update UI }

    FlourResultLabel.Caption := FormatFloat('0', Flour) + ' g';
    WaterResultLabel.Caption := FormatFloat('0', Water) + ' g';
    SaltResultLabel.Caption := FormatFloat('0.0', Salt) + ' g';
    YeastResultLabel.Caption := FormatFloat('0.00', Yeast) + ' g';
end;

procedure TMainForm.CalculateButtonClick(Sender: TObject);
begin
     Calculate;
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
     Calculate;
end;

end.


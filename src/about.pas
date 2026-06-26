unit about;

{$mode ObjFPC}{$H+}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

    { TAboutForm }

    TAboutForm = class(TForm)
        Image1: TImage;
        Label1: TLabel;
        Label2: TLabel;
        procedure Button1Click(Sender: TObject);
    private

    public

    end;

var
    AboutForm: TAboutForm;

implementation

{$R *.lfm}

{ TAboutForm }

procedure TAboutForm.Button1Click(Sender: TObject);
begin
    self.Free;
end;

end.


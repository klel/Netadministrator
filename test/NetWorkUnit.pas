unit NetWorkUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, ExtCtrls;

type
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  THabBtn = class(TGraphicControl)
  private
    FOnPaint: TNotifyEvent;
    MouseExsist:Boolean;
    BC:TColor;
    FFlat:Boolean;
    FPortNum:Byte;
    FHabName:string;
    FIcon:TIcon;
    FIconProp:WORD;
    procedure CMMouseEnter (var message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave (var message: TMessage); message CM_MOUSELEAVE;
    procedure SetFFlat(const Value: Boolean);
    procedure SetFIcon(const Value: TIcon);
    procedure SetIconProp(const Value: Word);
    procedure SetPortNum(const Value: Byte);
    procedure SetHabName(const Value: string);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Canvas;
  published
    property Align;
    property Anchors;
    property Color;
    property BorderColor: TColor read BC write BC;
    property Constraints;
    property Caption;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Flat:Boolean read FFlat write SetFFlat default False;
    property HabName:string read FHabName write SetHabName;
    property Icon:TIcon read FIcon write SetFIcon;
    property IconPropertis:Word read FIconProp write SetIconProp;
    property ParentColor;
    property ParentFont default False;
    property ParentShowHint;
    property PortNym:Byte read FPortNum write SetPortNum;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

procedure THabBtn.CMMouseEnter(var message: TMessage);
begin
MouseExsist:=True;
Repaint;
end;

procedure THabBtn.CMMouseLeave(var message: TMessage);
begin
MouseExsist:=False;
Repaint;
end;

constructor THabBtn.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 ControlStyle := ControlStyle + [csReplicatable];
 Width := 50;
 Height := 50;
 FIcon:=TIcon.Create;
 FIcon.Width := 32;
 FIcon.Height := 32;
 FIconProp:=32;
 FPortNum:=8;
 MouseExsist:=False;
 FHabName:='';
end;

procedure THabBtn.Paint;
var kl, kt, tl, tt:integer;
    IconSiz:integer;
    TR:TRect;
    OldBkMode : integer;
begin
Canvas.Font:=Font;
if Icon.Handle = 0
 then IconSiz:=0
 else IconSiz:=FIconProp;

tl:=(Width - Canvas.TextWidth(Caption))div(2);
tt:=(Height - Canvas.TextHeight(Caption))div(2);
kl:=(Width - IconSiz)div(2);
kt:=(Height - IconSiz)div(2);

if (MouseExsist)and(not FFlat)
 then begin
  Canvas.Pen.Color:=Color;
  Canvas.Brush.Color:=Color;
  Canvas.RoundRect(0,0, Width, Height, 5, 5);
 end;
if FFlat
 then begin
  Canvas.Pen.Color:=BC;
  Canvas.Brush.Color:=Color;
  kl:=kl+1;
  kt:=kt+1;
  Canvas.RoundRect(0,0, Width, Height, 5, 5);
 end;
DrawIconEx(Canvas.Handle, kl, kt,FIcon.Handle, FIconProp, FIconProp, 0, 0, DI_NORMAL);
TR:=Rect(tl, tt, Canvas.ClipRect.Right, Canvas.ClipRect.Bottom);
OldBkMode := SetBkMode(Canvas.Handle,1);
DrawText(Canvas.Handle, PChar(Caption), Length(Caption), TR, 0);
SetBkMode(Canvas.Handle,OldBkMode);
end;

procedure THabBtn.SetFFlat(const Value: Boolean);
begin
  FFlat := Value;
  Repaint;
end;

procedure THabBtn.SetFIcon(const Value: TIcon);
begin
  FIcon.Assign(Value);
  Repaint;
end;

procedure THabBtn.SetHabName(const Value: string);
begin
  FHabName := Value;
end;

procedure THabBtn.SetIconProp(const Value: Word);
begin
 if FIconProp = Value
  then exit;
  FIconProp := Value;
end;

procedure THabBtn.SetPortNum(const Value: Byte);
begin
  FPortNum := Value;
end;

end.

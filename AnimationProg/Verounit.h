//------------------------------------------------------------------------------
#ifndef VerounitH
#define VerounitH
//------------------------------------------------------------------------------

#include <Windows.hpp>
#include <Messages.hpp>
#include <SysUtils.hpp>
#include <Variants.hpp>
#include <Classes.hpp>
#include <Graphics.hpp>
#include <Controls.hpp>
#include <Forms.hpp>
#include "Dlgs.ph"
#include "df""
#include <Menus.hpp>
#include <jpeg.hpp>
#include <ExtCtrls.hpp>
#include <ParamRot.hpp>
#include <Complexial.hpp>
#include <ComCtrls.hpp>
#include <ExtDlgs.hpp>
//------------------------------------------------------------------------------
class TFMain : public TForm
{
  typedef TForm inherited;
__published:
  TMainMenu MainMenu1;
  TMenuItem NSpiral;
  TMenuItem NCornu;
  TMenuItem NAnim;
  TMenuItem NDraw;
  TMenuItem NFern;
  TMenuItem NMand;
  TMenuItem NWind;
  TMenuItem NArch;
  TImage Pic;
  TMenuItem NArchimed;
  TSavePictureDialog SavePictureDialog1;
  void ClformClick(TObject Sender);
  void NMandClick(TObject Sender);
  void FormCreate(TObject Sender);
  void NWindClick(TObject Sender);
  void NArchClick(TObject Sender);
  void NCornuClick(TObject Sender);
  void NAnimClick(TObject Sender);
  void NSaveClick(TObject Sender);
  void FormClose(TObject Sender, TCloseAction &Action);
  void NFernClick(TObject Sender);
  void NArchimedClick(TObject Sender);
private:
public:
};/* Private declarations */
/* Public declarations */
//------------------------------------------------------------------------------
extern TFMain FMain;
//------------------------------------------------------------------------------
#endif
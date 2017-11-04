VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CList"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'//////////////////////////////////////////////////////////////////////////////
'@@summary ֧�ּ򵥵��б���֧���ض�����
'@@require
'@@reference
'@@license
'@@author
'@@create
'@@modify
'//////////////////////////////////////////////////////////////////////////////


'//////////////////////////////////////////////////////////////////////////////
'//
'//      ��������
'//
'//////////////////////////////////////////////////////////////////////////////


'------------------------------------------------------------------------------
'       �ӿڼ̳�
'------------------------------------------------------------------------------


'------------------------------------------------------------------------------
'       ���г���
'------------------------------------------------------------------------------


'------------------------------------------------------------------------------
'       ������������
'------------------------------------------------------------------------------


'------------------------------------------------------------------------------
'       ���б���
'------------------------------------------------------------------------------


'------------------------------------------------------------------------------
'       ����API
'------------------------------------------------------------------------------


'------------------------------------------------------------------------------
'       �¼�����
'------------------------------------------------------------------------------


'//////////////////////////////////////////////////////////////////////////////
'//
'//      ˽������
'//
'//////////////////////////////////////////////////////////////////////////////


'------------------------------------------------------------------------------
'       ˽�г���
'------------------------------------------------------------------------------
Private Const INIT_SIZE = 1024
Private Const INIT_GAP_SIZE = 128

'------------------------------------------------------------------------------
'       ˽����������
'------------------------------------------------------------------------------


'------------------------------------------------------------------------------
'       ˽�б���
'------------------------------------------------------------------------------
Private mArr() As Variant
Private mCount As Long
Private mSize As Long

'------------------------------------------------------------------------------
'       ���Ա���
'------------------------------------------------------------------------------


'------------------------------------------------------------------------------
'       ˽��API
'------------------------------------------------------------------------------


'//////////////////////////////////////////////////////////////////////////////
'//
'//      ��
'//
'//////////////////////////////////////////////////////////////////////////////


'------------------------------------------------------------------------------
'       ��ʼ��
'------------------------------------------------------------------------------
Private Sub Class_Initialize()
  mCount = 0
  mSize = INIT_SIZE
  ReDim mArr(1 To mSize)
End Sub


'------------------------------------------------------------------------------
'       ����
'------------------------------------------------------------------------------
Private Sub Class_Terminate()

End Sub


'//////////////////////////////////////////////////////////////////////////////
'//
'//      �¼�����
'//
'//////////////////////////////////////////////////////////////////////////////


'//////////////////////////////////////////////////////////////////////////////
'//
'//      ˽������
'//
'//////////////////////////////////////////////////////////////////////////////


'//////////////////////////////////////////////////////////////////////////////
'//
'//      ˽�з���
'//
'//////////////////////////////////////////////////////////////////////////////
Private Sub resize()
  mSize = mSize + INIT_GAP_SIZE
  ReDim Preserve mArr(1 To mSize)
End Sub

'//////////////////////////////////////////////////////////////////////////////
'//
'//      �̳�ʵ��
'//
'//////////////////////////////////////////////////////////////////////////////


'//////////////////////////////////////////////////////////////////////////////
'//
'//      ��������
'//
'//////////////////////////////////////////////////////////////////////////////
Public Property Get Item(ByVal index As Long) As Variant
  If index > mCount Or index < 1 Then
    Err.Raise 10032301, , "[SunSoft]����������Χ"
  End If
  Item = mArr(index)
End Property

Public Property Let Item(ByVal index As Long, value As Variant)
  If index > mCount Or index < 1 Then
    Err.Raise 10032301, , "[SunSoft]����������Χ"
  End If
  mArr(index) = value
End Property

Public Property Get Count() As Long
  Count = mCount
End Property
'//////////////////////////////////////////////////////////////////////////////
'//
'//      ���з���
'//
'//////////////////////////////////////////////////////////////////////////////
Public Function Add(ByVal value As Variant) As CList
  If mCount >= mSize Then
    Call resize
  End If
  mCount = mCount + 1
  mArr(mCount) = value
  Set Add = Me
End Function

Public Function ToArray() As String()
  Dim arr() As String, i As Long
  
  If mCount = 0 Then
    ToArray = arr
    Exit Function
  End If
  
  ReDim arr(mCount - 1)
  For i = 0 To mCount - 1
    arr(i) = CStr(mArr(i + 1))
  Next i
  ToArray = arr
End Function

Public Function Join(Optional ByVal Separator As String = "", Optional ByVal Start As Long = 1) As String
  Dim joins As String, i As Long
  
  If mCount = 0 Then
    Join = ""
    Exit Function
  End If

  For i = Start To mCount
    joins = joins & Separator & CStr(mArr(i))
  Next i
  
  joins = Mid(joins, Len(Separator) + 1)
  
  Join = joins
End Function

Public Function WrapJoin(Optional ByVal Separator As String = "", Optional ByVal Wraper As String = "", Optional ByVal Start As Long = 1) As String
  Dim joins As String, i As Long
  
  If mCount = 0 Then
    WrapJoin = ""
    Exit Function
  End If

  For i = Start To mCount
    joins = joins & Separator & Wraper & CStr(mArr(i)) & Wraper
  Next i
  
  joins = Mid(joins, Len(Separator) + 1)
  
  WrapJoin = joins
End Function

Public Sub Clear()
  Call Class_Initialize
End Sub

Public Function LoadFromString(ByVal DataString As String, ByVal Delimiter As String) As CList
  Dim mArr() As String, i As Long
  Call Clear
  If DataString = "" Then
    Set LoadFromString = Me
    Exit Function
  End If
  mArr = Split(DataString, Delimiter)
  For i = 0 To UBound(mArr)
    Add mArr(i)
  Next i
  Set LoadFromString = Me
End Function
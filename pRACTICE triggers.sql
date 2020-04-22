use SchoolManagementSystemDB


create trigger TR_SMS_Insert
On StudentDetails
After Insert As
Begin
Set Nocount On;
Insert Into StudentDetails
(StudentDetailId, StudentId, Address, MotherTongue, AadharCardNumber, Nationality, Gender, Religion, BloodGroup, LastSchoolName)
Select s.StudentDetailId,s.StudentId, s.Address, s.MotherTongue, s.AadharCardNumber, s.Nationality, s.Gender, s.Religion, s.BloodGroup, s.LastSchoolName From inserted as S;
End




CREATE TRIGGER TR_SMS_DELETE
ON StudentDetails
After Delete As
BEGIN
SET NOCOUNT ON;
UPDATE s set s.Gender = 1
from StudentDetails as S
where exists (select 1 from deleted as d where s.StudentDetailId = d.StudentDetailId);
end




CREATE TRIGGER TR_SMS_UPDATE
ON StudentDetails
After UPDATE As
BEGIN
SET NOCOUNT ON;
UPDATE S set s.Nationality= 'Indian'
from StudentDetails as S
Inner Join inserted as I
On i.StudentDetailId=s.StudentDetailId;
end




CREATE TRIGGER TR_SMS_INSERTS
ON StudentDetails
INSTEAD OF INSERT As
BEGIN
SET NOCOUNT ON;
Insert Into StudentDetails
(StudentDetailId, StudentId, Address, MotherTongue, AadharCardNumber, Nationality, Gender, Religion, BloodGroup, LastSchoolName)
Select s.StudentDetailId,s.StudentId, s.Address, s.MotherTongue, s.AadharCardNumber, s.Nationality, s.Gender, s.Religion, s.BloodGroup, s.LastSchoolName From inserted as S;
End



CREATE TRIGGER TR_SMS_updates
ON StudentDetails
INSTEAD OF update As
BEGIN
SET NOCOUNT ON;
UPDATE S set s.Nationality= 'Indian'
from StudentDetails as S
Inner Join inserted as I
On i.StudentDetailId=s.StudentDetailId;
end


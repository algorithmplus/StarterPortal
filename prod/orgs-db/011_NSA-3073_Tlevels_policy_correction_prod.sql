BEGIN TRAN UPDATETLEVELSPOLICYCONDITION

update PolicyCondition set [Value]='72ed2dcb-7fa3-456c-9618-21f52c314d54' where Id='6c4c614c-98f6-4e1c-b584-f0bf056cfa96' and PolicyId='c47371c9-198d-4202-b411-d60cd8593db6';

ROLLBACK TRAN UPDATETLEVELSPOLICYCONDITION

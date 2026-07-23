import { IsBoolean } from 'class-validator';

export class UpdateNotificationsDto {
    
  @IsBoolean()
  notificationsEnabled: boolean;
}
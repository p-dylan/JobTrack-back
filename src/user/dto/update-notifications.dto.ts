import { IsBoolean } from 'class-validator';

export class UpdateNotificationsDto {
  @IsBoolean()
  notifications_enabled: boolean;
}

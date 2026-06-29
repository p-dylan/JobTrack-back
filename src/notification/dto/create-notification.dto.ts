import { IsBoolean, IsEnum, IsNotEmpty } from "class-validator";
import { notification_event_type } from "prisma/generated/prisma/enums";

export class CreateNotificationDto {

    @IsNotEmpty()
    @IsEnum(notification_event_type)
    event_type: notification_event_type;


    @IsNotEmpty()
    @IsBoolean()
    is_read: boolean
}

import { IsBoolean, IsEnum, IsNotEmpty } from "class-validator";
import { Notification_event_type } from "prisma/generated/prisma/enums";

export class CreateNotificationDto {

    @IsNotEmpty()
    @IsEnum(Notification_event_type)
    event_type: Notification_event_type;


    @IsNotEmpty()
    @IsBoolean()
    is_read: boolean
}

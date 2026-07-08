
import { Body, Controller, Post, Get, Put, Delete, Param, ParseIntPipe, UseGuards, Req } from '@nestjs/common';
import { UserService } from './user.service';
import { UpdateUserDto } from './dto/update-user.dto';
import { Prisma, User } from 'prisma/generated/prisma/client';
import { UserWithoutPass } from './interface/partielUser';
import { PrismaService } from 'prisma/prisma.service';
import { AuthGuard } from 'src/auth/guards/auth.guard';
import type { IRequestWithPayload } from 'src/auth/interface';
import type { Request } from 'express';


@UseGuards(AuthGuard)
@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService, private readonly prismaService: PrismaService) {}

  // @Post()
  // async create(@Body() body: CreateUserDto): Promise<{data: {user: user}; message: string}> {
  //   const user = await this.userService.create(body);
  //   return {data: {user}, message: 'user create successfull'};
  // }

  @Get(':id')
  async findOne(@Param('id', ParseIntPipe) id: number): Promise<UserWithoutPass> {
    return this.userService.findOneOrThrow(id);
  }

  @Get('profil')
  async getMyProfil(@Req() request: IRequestWithPayload): Promise<UserWithoutPass> {
    return await this.userService.findOneOrThrow(request.user.id);
  }

  @Get()
   async findAll(): Promise<UserWithoutPass[]> {
    return await this.userService.findAll();
  }



  @Put(':id')
  async updateUser(
    @Param('id', ParseIntPipe) id: number, 
    @Body() body: UpdateUserDto): Promise<UserWithoutPass> {
      return await this.userService.update(id, body);
  }

  @Delete(':id')
  async deleteUser(@Param('id', ParseIntPipe) id: number): Promise<{data : null; message: string}> {
    await this.userService.delete(id);
    return { data: null, message: `Le user avec l'id ${id} a été supprimé avec succès.` };
  }

  @Delete()
  async deleteAll(): Promise<Prisma.BatchPayload> {
    return this.userService.deleteAll();
  }
}
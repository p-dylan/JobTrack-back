
import { Body, Controller, Post, Get, Put, Delete, Param, ParseIntPipe } from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { IPartialUser} from './interface/partielUser';
import { Prisma, user } from 'prisma/generated/prisma/client';

@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Post()
  async create(@Body() body: CreateUserDto): Promise<{data: {user: user}; message: string}> {
    const user = await this.userService.create(body);
    return {data: {user}, message: 'user create successfull'};
  }

  @Get(':id')
  async findOne(@Param('id', ParseIntPipe) id: number): Promise<IPartialUser<{ user : user}>> {
    const user = await this.userService.findOne(id);
    return {data : {user}, message: `User with id: ${id} found.`};
    
  }

  @Get()
  async findAll(): Promise<IPartialUser<user[]>> {
    const users = await this.userService.findAll();
    return {
      data: users,
      message: users.length === 0
        ? `Aucun user n'a été trouvé.`
        : `${users.length} users trouvé(s).`,
    };
  }



 

  @Put(':id')
  async updateUser(
    @Param('id', ParseIntPipe) id: number, 
    @Body() body: UpdateUserDto): Promise<IPartialUser<{ user: user }>> {
      const user = await this.userService.update(id, body);
      return { data: { user }, message: `le user avec l'id ${id} a été mis a jour avec succès.` };
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
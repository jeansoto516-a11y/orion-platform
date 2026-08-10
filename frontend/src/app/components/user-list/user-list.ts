import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { User } from '../../models/user';
import { UserService } from '../../services/user';

@Component({
  selector: 'app-user-list',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './user-list.html',
  styleUrl: './user-list.scss'
})
export class UserList implements OnInit {
  users: User[] = [];
  newUser: User = { name: '', email: '' };
  loading = false;
  errorMessage = '';

  constructor(private userService: UserService) {}

  ngOnInit(): void {
    this.loadUsers();
  }

  loadUsers(): void {
    this.loading = true;
    this.userService.getUsers().subscribe({
      next: (data) => {
        this.users = data;
        this.loading = false;
      },
      error: (err) => {
        this.errorMessage = 'Erro ao carregar usuários. Verifique se a API está rodando.';
        this.loading = false;
        console.error(err);
      }
    });
  }

  addUser(): void {
    if (!this.newUser.name || !this.newUser.email) {
      return;
    }
    this.userService.createUser(this.newUser).subscribe({
      next: () => {
        this.newUser = { name: '', email: '' };
        this.loadUsers();
      },
      error: (err) => {
        this.errorMessage = 'Erro ao cadastrar usuário.';
        console.error(err);
      }
    });
  }
}
package com.orion.platform.orion_backend.repository;

import com.orion.platform.orion_backend.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
}

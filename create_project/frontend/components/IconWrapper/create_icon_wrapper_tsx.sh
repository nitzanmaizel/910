#!/bin/bash
mkdir -p frontend/src/components/IconWrapper

echo "Creating create_icon_wrapper_tsx file..."

# Create useSnackbar.tsx file with content
cat <<EOL > frontend/src/components/IconWrapper/IconWrapper.tsx
import React from 'react';
import { Box, Button, SvgIconProps } from '@mui/material';
import { IconWrapperProps, mapTypeToIcon } from './mapTypeToIcon';

const IconWrapper: React.FC<IconWrapperProps> = (props) => {
  const { type, isDark, isDisabled, sx, onClick, text, textSx, buttonSx, ...otherProps } = props;

  const iconSx = {
    color: isDark ? '#333' : isDisabled ? '#999' : '#000',
    ...sx,
  };

  if (typeof onClick === 'function' && !isDisabled) {
    return (
      <Button
        onClick={onClick as unknown as React.MouseEventHandler<HTMLButtonElement>}
        sx={{
          minWidth: '20px',
          display: 'flex',
          justifyContent: 'center',
          alignItems: 'center',
          ...buttonSx,
        }}
      >
        {mapTypeToIcon[type]({ ...otherProps, sx: iconSx } as SvgIconProps)}{' '}
        {text && <Box sx={{ ...textSx }}>{text}</Box>}
      </Button>
    );
  }

  return mapTypeToIcon[type] ? (
    <Box sx={{ minWidth: 0, display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
      {mapTypeToIcon[type]({ ...otherProps, sx: iconSx } as SvgIconProps)}
      {text && <Box sx={{ ...textSx }}>{text}</Box>}
    </Box>
  ) : (
    <Box>Icon type doesn't exist</Box>
  );
};

export default IconWrapper;
EOL